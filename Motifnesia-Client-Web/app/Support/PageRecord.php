<?php

namespace App\Support;

use JsonSerializable;

class PageRecord implements JsonSerializable
{
    public function __construct(private array $fields) {}

    public function __get(string $name): mixed
    {
        return $this->fields[$name] ?? null;
    }

    public function __isset(string $name): bool
    {
        return isset($this->fields[$name]);
    }

    public function isMemberActive(): bool
    {
        return $this->membership_active;
    }

    public function sizeQuantities(): array
    {
        return $this->size_quantities;
    }

    public function jsonSerialize(): array
    {
        return $this->fields;
    }
}
