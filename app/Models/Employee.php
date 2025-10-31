<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Employee extends Model
{
    use HasFactory;

    protected $fillable = [
        'name',
        'email',
        'phone',
        'username',
        'password',
        'profile_photo',
        'address',
        'position',
        'salary',
        'joining_date',
        'termination_date',
        'notes',
        'status',
    ];

    // Automatically return full URL for profile_photo
    public function getProfilePhotoAttribute($value)
    {
        return $value ? url($value) : null;
    }

    // Hide password in JSON responses
    protected $hidden = [
        'password',
    ];
}
