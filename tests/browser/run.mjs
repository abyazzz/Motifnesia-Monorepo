import assert from 'node:assert/strict';
import { spawn, execFileSync } from 'node:child_process';
import { randomBytes } from 'node:crypto';
import { access, mkdir, mkdtemp, writeFile } from 'node:fs/promises';
import { createServer } from 'node:net';
import { tmpdir } from 'node:os';
import path from 'node:path';
import { fileURLToPath } from 'node:url';
import { setTimeout as delay } from 'node:timers/promises';
import { Chrome } from './chrome.mjs';

const root = fileURLToPath(new URL('../../', import.meta.url));
const server = path.join(root, 'Motifnesia-Server');
const client = path.join(root, 'Motifnesia-Client-Web');
const artifacts = await mkdtemp(path.join(tmpdir(), 'motifnesia-browser-'));
const database = path.join(artifacts, 'browser-test.sqlite');
const proof = path.join(artifacts, 'payment-proof.png');
const processes = [];
const chrome = new Chrome(path.join(artifacts, 'chrome'));
const password = 'motifnesia-browser-test';

try {
    await chrome.send('Browser.getVersion');
    await access(path.join(client, 'public/build/manifest.json'));
    const apiOrigin = await localOrigin();
    const webOrigin = await localOrigin();

    await writeFile(database, '', { flag: 'wx' });
    await writeFile(proof, Buffer.from(
        'iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAQAAAC1HAwCAAAAC0lEQVR42mP8/x8AAwMCAO8DbXcAAAAASUVORK5CYII=',
        'base64',
    ));

    const serverEnv = await appEnv('server', apiOrigin);
    serverEnv.ASSET_URL = apiOrigin;
    serverEnv.MOTIFNESIA_WORKFLOW_STORE = 'file';

    const clientEnv = await appEnv('client', webOrigin);
    clientEnv.MOTIFNESIA_API_URL = apiOrigin + '/api/v1';
    clientEnv.MOTIFNESIA_MEDIA_URL = apiOrigin;
    clientEnv.SESSION_COOKIE = 'motifnesia_browser_test';
    clientEnv.SESSION_ENCRYPT = 'true';

    const fixtureScript = fileURLToPath(new URL('fixtures.php', import.meta.url));
    php(server, serverEnv, [fixtureScript, '--check']);
    php(server, serverEnv, ['artisan', 'migrate', '--force', '--quiet']);
    php(server, serverEnv, [fixtureScript]);

    launch(server, serverEnv, apiOrigin);
    launch(client, clientEnv, webOrigin);
    await waitFor(async () => (await fetch(apiOrigin + '/up')).ok, 'health check server');
    await waitFor(async () => (await fetch(webOrigin + '/up')).ok, 'health check client');

    const { targetId } = await chrome.send('Target.createTarget', { url: 'about:blank' });
    const { sessionId } = await chrome.send('Target.attachToTarget', { targetId, flatten: true });
    const command = (method, params) => chrome.send(method, params, sessionId);
    await command('Page.enable');
    await command('Network.enable');

    const evaluate = async (expression) => {
        const { result, exceptionDetails } = await command('Runtime.evaluate', {
            expression, awaitPromise: true, returnByValue: true, userGesture: true,
        });
        assert(!exceptionDetails, exceptionDetails?.exception?.description ?? exceptionDetails?.text);
        return result.value;
    };
    const pathname = (expected) => waitFor(
        () => evaluate(`location.pathname === ${JSON.stringify(expected)} && document.readyState === 'complete'`),
        'halaman '+expected,
    );
    const go = async (endpoint, target = endpoint) => {
        const result = await command('Page.navigate', { url: webOrigin + endpoint });
        assert(!result.errorText, result.errorText);
        await pathname(target);
    };
    const click = (selector) => evaluate(`document.querySelector(${JSON.stringify(selector)}).click()`);
    const fill = (selector, value) => evaluate(
        `document.querySelector(${JSON.stringify(selector)}).value = ${JSON.stringify(value)}`,
    );
    const contains = (text) => waitFor(
        () => evaluate(`document.body.innerText.includes(${JSON.stringify(text)})`),
        'teks '+text,
    );
    const screenshot = async (name) => {
        const { data } = await command('Page.captureScreenshot', { format: 'png' });
        await writeFile(path.join(artifacts, name + '.png'), Buffer.from(data, 'base64'));
    };
    const login = async (username, landing) => {
        await command('Network.clearBrowserCookies');
        await go('/login');
        await fill('#username', username);
        await fill('#loginPassword', password);
        await click('form[action$="/login"] button[type="submit"]');
        await pathname(landing);
    };
    const dbValue = (query) => execFileSync('php', [
        '-r', 'echo (new PDO("sqlite:".$argv[1]))->query($argv[2])->fetchColumn();', database, query,
    ], { encoding: 'utf8' });

    await go('/', '/homePage');
    await contains('Batik Browser Test');
    await go('/cart', '/login');
    await login('customer', '/homePage');
    await go('/products/1');
    await click('.size-btn[data-size="M"]');
    await click('#btnAddToCart');
    await waitFor(() => dbValue('select qty from shopping_card') === '1', 'produk masuk keranjang');
    await go('/cart');
    await click('.item-checkbox');
    await click('form[action$="/cart/checkout"] button[type="submit"]');
    await pathname('/checkout');
    await click('input[name="metode_pengiriman"][value="1"]');
    await click('input[name="metode_pembayaran"][value="1"]');
    await click('#btn_bayar');
    await pathname('/payment');
    await fill('#payment_number', '081234567891');
    const { root: document } = await command('DOM.getDocument');
    const { nodeId } = await command('DOM.querySelector', { nodeId: document.nodeId, selector: '#payment_proof' });
    assert(nodeId, 'Input bukti pembayaran tidak ditemukan.');
    await command('DOM.setFileInputFiles', { nodeId, files: [proof] });
    await click('#form_payment button[type="submit"]');
    await pathname('/transaction/success/1');
    assert.equal(dbValue('select payment_status from orders where id=1'), 'waiting_verification');
    assert.equal(dbValue('select stok from product_size_stocks where produk_id=1'), '9');
    await screenshot('checkout-sukses');
    await go('/profile');
    await click('form[action$="/logout"] button[type="submit"]');
    await pathname('/login');
    await go('/profile', '/login');
    console.log('Lulus: login customer, keranjang AJAX, checkout, unggah bukti, dan logout.');

    await login('finance', '/admin/order-status');
    await go('/admin/order-status/1/payment-proof');
    await waitFor(() => evaluate('Boolean(document.querySelector("img")?.naturalWidth)'), 'gambar bukti pembayaran');
    await login('kasir', '/admin/product-management');
    const forbidden = await evaluate(`fetch('/admin/order-status/1/payment-proof', {
        headers: { Accept: 'application/json' }
    }).then(response => response.status)`);
    assert.equal(forbidden, 403);
    await login('owner', '/admin/product-management');
    await go('/admin/suppliers');
    await contains('Supplier Browser Test');
    console.log('Lulus: akses finance, pembatasan kasir, dan halaman supplier untuk owner.');

    await login('gudang', '/admin/warehouse');
    await go('/admin/stock-procurements/create');
    await fill('[name="supplier_id"]', '1');
    await fill('[name="items[1][qty_m]"]', '5');
    await evaluate('document.querySelector(\'form[action$="/admin/stock-procurements"]\').requestSubmit()');
    await pathname('/admin/stock-procurements/1');

    await login('supplier-lain', '/supplier/procurements');
    const forbiddenProcurement = await evaluate(`fetch('/supplier/procurements/1', {
        headers: { Accept: 'application/json' }
    }).then(response => response.status)`);
    assert.equal(forbiddenProcurement, 403);
    await login('supplier', '/supplier/procurements');
    await go('/supplier/procurements/1');
    await click('form:has(input[name="status"][value="approved"]) button');
    await waitFor(() => evaluate('Boolean(document.querySelector(\'input[name="status"][value="in_delivery"]\'))'), 'pengadaan disetujui');
    await click('form:has(input[name="status"][value="in_delivery"]) button');
    await waitFor(() => dbValue('select status from stock_procurements where id=1') === 'in_delivery', 'status diantar');
    await contains('Status pengadaan berhasil diperbarui menjadi Diantar.');
    await screenshot('pengadaan-supplier');

    await login('gudang', '/admin/warehouse');
    await go('/admin/stock-procurements/1');
    await click('form[action$="/confirm-arrived"] button[type="submit"]');
    await waitFor(() => evaluate('Boolean(document.querySelector(\'form[action$="/apply-stock"]\'))'), 'barang sampai');
    await evaluate('window.confirm = () => true');
    await click('form[action$="/apply-stock"] button[type="submit"]');
    await contains('Stok gudang dan stok sistem berhasil diterapkan.');
    assert.equal(dbValue('select stok from product_size_stocks where produk_id=1'), '14');
    assert.equal(dbValue('select stok from warehouse_stocks where produk_id=1'), '15');
    console.log('Lulus: pengadaan gudang dan supplier, hingga perubahan stok.');

    await command('Emulation.setDeviceMetricsOverride', {
        width: 390, height: 844, deviceScaleFactor: 1, mobile: true,
    });
    await command('Network.clearBrowserCookies');
    await go('/homePage');
    await contains('Batik Browser Test');
    await screenshot('katalog-mobile');
    console.log(`Artefak browser: ${artifacts}`);
} catch (error) {
    console.error(error.message);
    console.error(`Folder pengujian: ${artifacts}`);
    process.exitCode = 1;
} finally {
    chrome.close();
    processes.forEach((process) => process.kill());
}

function php(cwd, env, args) {
    return execFileSync('php', args, { cwd, env, stdio: 'inherit' });
}

function launch(cwd, env, origin) {
    const router = path.join(cwd, 'vendor/laravel/framework/src/Illuminate/Foundation/resources/server.php');
    const server = spawn('php', ['-S', new URL(origin).host, router], {
        cwd: path.join(cwd, 'public'), env, stdio: ['ignore', 'ignore', 'pipe'],
    });
    server.stderr.resume();
    processes.push(server);
}

async function appEnv(name, origin) {
    const storage = path.join(artifacts, name);
    await Promise.all([
        'framework/cache/data', 'framework/sessions', 'framework/views', 'logs', 'app/private',
    ].map((dir) => mkdir(path.join(storage, dir), { recursive: true })));

    return {
        ...process.env,
        APP_ENV: 'local',
        APP_DEBUG: 'false',
        APP_KEY: 'base64:' + randomBytes(32).toString('base64'),
        APP_URL: origin,
        APP_CONFIG_CACHE: path.join(storage, 'config.php'),
        APP_ROUTES_CACHE: path.join(storage, 'routes.php'),
        LARAVEL_STORAGE_PATH: storage,
        DB_CONNECTION: 'sqlite',
        DB_DATABASE: database,
        DB_URL: '',
        SESSION_DRIVER: 'file',
        CACHE_STORE: 'file',
        MAIL_MAILER: 'array',
        QUEUE_CONNECTION: 'sync',
    };
}

async function localOrigin() {
    const server = createServer();
    await new Promise((resolve, reject) => {
        server.once('error', reject);
        server.listen(0, '127.0.0.1', resolve);
    });
    const { port } = server.address();
    await new Promise((resolve, reject) => server.close((error) => error ? reject(error) : resolve()));
    return `http://127.0.0.1:${port}`;
}

async function waitFor(callback, label) {
    const deadline = Date.now() + 20000;
    let lastError;
    while (Date.now() < deadline) {
        try {
            if (await callback()) return;
        } catch (error) {
            lastError = error;
        }
        await delay(150);
    }
    throw new Error('Waktu tunggu habis untuk '+label+'.', { cause: lastError });
}
