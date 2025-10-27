<?php
namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
class Purchase extends Model
{
       use HasFactory;

    protected $fillable = [
      'supplier_id','invoice_no','purchase_date','subtotal','discount','tax', 'product_id',
      'total_cost','paid_amount','due_amount','payment_status','note','user_id'
    ];

    public function supplier() { return $this->belongsTo(Supplier::class); }
    public function items()    { return $this->hasMany(PurchaseItem::class); }
    public function user()     { return $this->belongsTo(User::class); }
}
