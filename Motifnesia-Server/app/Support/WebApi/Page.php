<?php

namespace App\Support\WebApi;

use App\Models\MembershipReward;
use App\Models\Notification;
use App\Models\Produk;
use App\Models\ProductReturn;
use App\Models\StockProcurement;
use App\Models\StockProcurementItem;
use App\Models\User;
use DateTimeInterface;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Http\JsonResponse;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Collection;
use Illuminate\Support\Facades\Auth;

class Page
{
    public static function response(string $view, array $data): JsonResponse
    {
        return response()->json([
            'page' => $view,
            'data' => self::encode($data),
            'viewer' => Viewer::data(Auth::user()),
        ]);
    }

    private static function encode(mixed $value): mixed
    {
        return match (true) {
            $value instanceof LengthAwarePaginator => [
                '_type' => 'pagination',
                'items' => self::encode($value->items()),
                'total' => $value->total(),
                'per_page' => $value->perPage(),
                'current_page' => $value->currentPage(),
                'page_name' => $value->getPageName(),
            ],
            $value instanceof Collection => ['_type' => 'collection', 'items' => self::encode($value->all())],
            $value instanceof Model => ['_type' => 'record', 'fields' => self::encode(self::fields($value))],
            $value instanceof DateTimeInterface => ['_type' => 'datetime', 'iso' => $value->format(DATE_ATOM)],
            is_array($value) => array_map(self::encode(...), $value),
            default => $value,
        };
    }

    private static function fields(Model $model): array
    {
        // Public review authors and private staff-facing user records have different fields.
        if ($model instanceof User) {
            $keys = ['id', 'name', 'full_name', 'profile_pic', 'profile_pic_url'];
            if (Auth::user()?->role === 'admin') {
                $keys = [...$keys, 'email', 'phone_number', 'role', 'account_status', 'account_status_reason',
                    'is_member', 'membership_status', 'reward_points', 'created_at', 'membership_joined_at',
                    'membership_tier', 'total_spending', 'reward_redemptions_count'];
            }
            if ((int) $model->id === (int) Auth::id()) {
                $keys = [...$keys, 'membership_status', 'membership_joined_at', 'reward_points',
                    'membership_tier', 'membership_tier_info', 'total_spending', 'email', 'phone_number'];
            }

            $computed = (int) $model->id === (int) Auth::id()
                ? ['membership_active' => $model->isMemberActive()]
                : [];

            return $model->only($keys) + $computed + array_intersect_key($model->getRelations(), ['orders' => true]);
        }

        $computed = match (true) {
            $model instanceof Produk => ['image_url' => $model->image_url],
            $model instanceof Notification => [
                'time_ago' => $model->time_ago,
                'icon' => $model->icon,
                'priority_color' => $model->priority_color,
            ],
            $model instanceof ProductReturn => ['time_ago' => $model->time_ago, 'status_color' => $model->status_color],
            $model instanceof StockProcurement => ['status_label' => $model->status_label, 'total_qty' => $model->total_qty],
            $model instanceof StockProcurementItem => ['size_quantities' => $model->sizeQuantities()],
            $model instanceof MembershipReward => ['discount_label' => $model->discount_label, 'exists' => $model->exists],
            default => [],
        };

        $hidden = array_fill_keys($model->getHidden(), true);
        $attributes = $model->only(array_keys(array_diff_key($model->getAttributes(), $hidden)));

        return $attributes + $computed + array_diff_key($model->getRelations(), $hidden);
    }
}
