<?php

return [
    'client_url' => env('MOTIFNESIA_CLIENT_URL', 'http://127.0.0.1:8001'),
    // Use a shared cache store with atomic locks when running multiple workers.
    'workflow_store' => env('MOTIFNESIA_WORKFLOW_STORE', 'file'),
];
