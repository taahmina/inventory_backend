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
        Schema::table('purchases', function (Blueprint $table) {
             $table->string('invoice_no')->unique()->after('id');
            $table->decimal('subtotal', 10, 2)->default(0);
            $table->decimal('discount', 10, 2)->default(0)->after('subtotal');
            $table->decimal('tax', 10, 2)->default(0)->after('discount');
            $table->decimal('total_cost', 10, 2)->default(0)->after('tax');
            $table->decimal('paid_amount', 10, 2)->default(0)->after('total_cost');
            $table->decimal('due_amount', 10, 2)->default(0)->after('paid_amount');
            $table->string('payment_status')->default('due')->after('due_amount'); // paid, partial, due
            $table->text('note')->nullable()->after('payment_status');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::table('purchases', function (Blueprint $table) {
             $table->dropColumn([
                'invoice_no', 'subtotal', 'discount', 'tax',
                'total_cost', 'paid_amount', 'due_amount',
                'payment_status', 'note'
            ]);
        });
    }
};
