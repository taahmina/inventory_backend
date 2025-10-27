<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    use HasFactory;
    protected $fillable = [
        'name',
        'unit',
        'sku',
        'image',
        'category_id',
        'supplier_id',
        'brand',
        'description',
        'buy_price',
        'sell_price',
        'stock',
        'status'
    ];

    public function category()
    {
        return $this->belongsTo(Category::class);
    }

    public function supplier()
    {
        return $this->belongsTo(Supplier::class);
    }

    public function orderItems()
    {
        return $this->hasMany(OrderItem::class);
    }

    public function inventoryLogs()
    {
        return $this->hasMany(InventoryLog::class);
    }

  //image upload 
  
    public function getImageAttribute($value)
    {
        return $value ? url('/' . $value) : null;
    }
}
