import { spawn } from 'node:child_process';

export class Chrome {
    #process;
    #responses = new Map();
    #messageId = 0;
    #pendingOutput = '';
    #stderr = '';
    #failure;

    constructor(profile) {
        this.#process = spawn(process.env.MOTIFNESIA_CHROME ?? 'google-chrome', [
            '--headless', '--no-first-run', '--no-default-browser-check',
            '--disable-dev-shm-usage', '--disable-background-networking',
            '--remote-debugging-pipe', `--user-data-dir=${profile}`, 'about:blank',
        ], { stdio: ['ignore', 'ignore', 'pipe', 'pipe', 'pipe'] });

        this.#process.stderr.setEncoding('utf8');
        this.#process.stderr.on('data', (data) => { this.#stderr = (this.#stderr + data).slice(-3000); });
        this.#process.stdio[3].on('error', (error) => this.#reject(error));
        this.#process.stdio[4].setEncoding('utf8');
        this.#process.stdio[4].on('data', (data) => this.#read(data));

        this.#process.on('error', (error) => this.#reject(error));
        this.#process.on('exit', (code, signal) => {
            this.#reject(new Error(`Chrome berhenti (${signal ?? code}). ${this.#stderr.trim()}`));
        });
    }

    send(method, params = {}, sessionId) {
        if (this.#failure) {
            return Promise.reject(this.#failure);
        }

        const id = ++this.#messageId;
        return new Promise((resolve, reject) => {
            const deadline = setTimeout(() => {
                this.#responses.delete(id);
                reject(new Error(`Chrome tidak merespons ${method}. ${this.#stderr.trim()}`));
            }, 15000);

            this.#responses.set(id, { resolve, reject, deadline });
            this.#process.stdio[3].write(JSON.stringify({ id, method, params, sessionId }) + '\0');
        });
    }

    close() {
        this.#process.kill();
    }

    #read(data) {
        const messages = (this.#pendingOutput + data).split('\0');
        this.#pendingOutput = messages.pop();

        for (const message of messages) {
            const { id, result, error } = JSON.parse(message);
            const response = this.#responses.get(id);
            if (!response) continue;

            clearTimeout(response.deadline);
            this.#responses.delete(id);
            if (error) {
                response.reject(new Error(error.message));
            } else {
                response.resolve(result);
            }
        }
    }

    #reject(error) {
        this.#failure ??= error;
        for (const { reject, deadline } of this.#responses.values()) {
            clearTimeout(deadline);
            reject(error);
        }
        this.#responses.clear();
    }
}
