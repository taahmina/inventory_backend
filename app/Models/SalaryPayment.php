<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class SalaryPayment extends Model
{
    use HasFactory;

    protected $fillable = [
        'employee_id',
        'amount',
        'pay_date',
        'note',
    ];

    public function employee()
    {
        return $this->belongsTo(Employee::class);
    }
}
