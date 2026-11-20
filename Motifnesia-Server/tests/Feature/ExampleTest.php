<?php

namespace Tests\Feature;

use Tests\TestCase;

class ExampleTest extends TestCase
{
    public function test_frontend_routes_are_served_by_the_client(): void
    {
        $this->getJson('/login')->assertNotFound();
        $this->getJson('/admin/order-status')->assertNotFound();

        $this->getJson('/api/v1/viewer')->assertOk()->assertJsonPath('viewer', null);
        $this->getJson('/api/test')->assertOk()->assertJsonPath('success', true);
    }

    public function test_server_health_endpoint_is_available(): void
    {
        $this->get('/up')->assertOk();
    }
}
