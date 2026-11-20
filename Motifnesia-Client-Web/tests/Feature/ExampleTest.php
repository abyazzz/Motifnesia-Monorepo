<?php

namespace Tests\Feature;

use Illuminate\Http\Client\Request;
use Illuminate\Support\Facades\Http;
use Tests\TestCase;

class ExampleTest extends TestCase
{
    public function test_guest_home_redirects_to_catalog(): void
    {
        Http::preventStrayRequests();

        $this->get('/')->assertRedirect('/homePage');
    }

    public function test_login_keeps_the_bearer_token_in_the_server_side_session(): void
    {
        Http::preventStrayRequests();
        $base = config('motifnesia.api_url');
        Http::fake([
            $base.'/login' => Http::response(['token' => 'test-token', 'viewer' => ['home' => '/homePage']]),
            $base.'/cart' => Http::response(['viewer' => null, 'page' => 'customer.pages.shoppingCard', 'data' => [
                'items' => ['_type' => 'collection', 'items' => []],
                'total' => 0,
            ]]),
        ]);

        $this->post('/login', ['username' => 'fixture', 'password' => 'fixture-password'])
            ->assertRedirect('/homePage')->assertSessionHas('motifnesia_token', 'test-token')
            ->assertDontSee('test-token');
        $this->get('/cart')->assertOk()->assertDontSee('test-token');
        Http::assertSent(fn (Request $request) => $request->url() === $base.'/cart'
            && $request->hasHeader('Authorization', 'Bearer test-token'));
    }

    public function test_invalid_server_session_redirects_to_login(): void
    {
        Http::fake([config('motifnesia.api_url').'/profile' => Http::response(['message' => 'Sesi berakhir.'], 401)]);

        $this->withSession(['motifnesia_token' => 'old-test-token'])->get('/profile')
            ->assertRedirect('/login')->assertSessionMissing('motifnesia_token');
    }
}
