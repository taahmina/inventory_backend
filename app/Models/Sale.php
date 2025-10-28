<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sale extends Model
{
    use HasFactory;

     protected $fillable = [
        'customer_id',
        'quantity',
        'total_price',
        'sale_date',
        'invoice_no',
        'subtotal',
        'discount',
        'tax',
        'paid_amount',
        'due_amount',
        'payment_status',
        'note',
        'sale_date'
    ];

    public function customer()
    {
        return $this->belongsTo(Customer::class);
    }

    public function product()
    {
        return $this->belongsTo(Product::class);
    }

}
