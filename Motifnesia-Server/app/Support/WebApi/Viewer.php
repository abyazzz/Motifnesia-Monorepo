<?php

namespace App\Support\WebApi;

use App\Models\User;
use Illuminate\Support\Facades\Gate;

class Viewer
{
    public static function data(?User $user): ?array
    {
        if (! $user) {
            return null;
        }

        $abilities = ['is-owner', 'is-finance', 'is-kasir', 'is-gudang', 'is-supplier'];

        return [
            ...$user->only(['id', 'name', 'full_name', 'role', 'admin_role', 'profile_pic_url', 'membership_tier_info', 'total_spending']),
            'membership_active' => $user->isMemberActive(),
            'tier_discount' => $user->getTierDiscount(),
            'abilities' => array_values(array_filter($abilities, Gate::forUser($user)->allows(...))),
            'home' => self::home($user),
        ];
    }

    public static function home(?User $user): string
    {
        return match ($user?->role) {
            'supplier' => '/supplier/procurements',
            'admin' => match ($user->admin_role) {
                'finance' => '/admin/order-status',
                'gudang' => '/admin/warehouse',
                default => '/admin/product-management',
            },
            default => '/homePage',
        };
    }
}
