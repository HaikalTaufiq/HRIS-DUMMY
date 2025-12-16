<?php

return [

    /*
    |--------------------------------------------------------------------------
    | Laravel CORS Configuration
    |--------------------------------------------------------------------------
    */

    'paths' => [
        'api/*',
        'sanctum/csrf-cookie',
    ],

    'allowed_methods' => ['*'],

    'allowed_origins' => [
        'https://103.161.188.102:443',
        'https://103.161.188.102:444',
        'http://103.161.188.102:80',
        'http://localhost:64644',
        'http://localhost:5173',
        'https://yellow-frost-7be7.haikaltaufiq4.workers.dev'
    ],

    'allowed_origins_patterns' => [
        'https://*.workers.dev',
    ],

    'allowed_headers' => ['*'],

    'exposed_headers' => [],

    'max_age' => 0,

    'supports_credentials' => false,
];
