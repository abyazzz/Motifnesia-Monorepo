<?php

namespace App\Support;

use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Carbon;

class PageData
{
    public static function decode(mixed $value): mixed
    {
        if (! is_array($value)) {
            return $value;
        }

        return match ($value['_type'] ?? null) {
            'record' => new PageRecord(self::decode($value['fields'])),
            'collection' => collect(self::decode($value['items'])),
            'datetime' => Carbon::parse($value['iso']),
            'pagination' => new LengthAwarePaginator(
                self::decode($value['items']),
                $value['total'],
                $value['per_page'],
                $value['current_page'],
                [
                    'path' => request()->url(),
                    'query' => request()->query(),
                    'pageName' => $value['page_name'],
                ],
            ),
            default => array_map(self::decode(...), $value),
        };
    }
}
