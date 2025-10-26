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
        Schema::table('products', function (Blueprint $table) {
            
            $table->text('description')->nullable();
             $table->string('unit')->nullable();
            $table->integer('stock')->default(0);
            $table->string('brand')->nullable();
            $table->string('image')->nullable();
            
            $table->decimal('buy_price', 10, 2)->default(0);
            $table->decimal('sell_price', 10, 2)->default(0);
            
            $table->boolean('status')->default(true);  // active/inactive flag
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('products', function (Blueprint $table) {
                 Schema::dropIfExists('products');
        });
    }
};
