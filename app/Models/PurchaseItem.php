<?php

namespace App\Models;


use Illuminate\Database\Eloquent\Model;

class PurchaseItem extends Model
{
    use HasFactory;

    protected $fillable = ['purchase_id','product_id','quantity','unit_price','total_cost'];

    public function purchase() { return $this->belongsTo(Purchase::class); }
    public function product()  { return $this->belongsTo(Product::class); }
}
