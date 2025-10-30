<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::table('employees', function (Blueprint $table) {
             $table->string('username')->unique()->nullable();
            $table->string('password')->nullable();
             $table->string('profile_photo')->nullable();
            $table->date('termination_date')->nullable();
             $table->text('notes')->nullable();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('employees', function (Blueprint $table) {
            $table->dropColumn([
                'username', 'password','profile_photo', 'termination_date', 'notes'
            ]);
        });
    }
};
