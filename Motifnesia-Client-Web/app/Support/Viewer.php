<?php

namespace App\Support;

use Illuminate\Auth\GenericUser;

class Viewer extends GenericUser
{
    public function isMemberActive(): bool
    {
        return $this->membership_active;
    }

    public function getTierDiscount(): float
    {
        return $this->tier_discount;
    }
}
