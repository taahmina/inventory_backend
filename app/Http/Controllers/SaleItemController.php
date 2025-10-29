<?php

namespace App\Http\Controllers;

use App\Models\SaleItem;
use App\Models\Product;
use App\Models\Sale;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SaleItemController extends Controller
{
    public function index()
    {
        $items = SaleItem::with(['sale.customer', 'product'])->latest()->get();
        return response()->json($items);
    }

    public function show(SaleItem $saleItem)
    {
        return response()->json($saleItem->load(['sale.customer', 'product']));
    }

    public function update(Request $request, SaleItem $saleItem)
    {
        $validated = $request->validate([
            'quantity' => 'nullable|integer|min:1',
        ]);

        DB::transaction(function () use ($saleItem, $validated) {
            $oldQty = $saleItem->quantity;
            $newQty = $validated['quantity'] ?? $oldQty;

            $product = Product::findOrFail($saleItem->product_id);
            $unit_price = $product->sell_price; // Always use current sell price

            $saleItem->update([
                'quantity' => $newQty,
                'unit_price' => $unit_price,
                'total_price' => $newQty * $unit_price,
            ]);

            // Adjust stock (increase back if reduced quantity, decrease if increased)
            $difference = $oldQty - $newQty;
            Product::where('id', $saleItem->product_id)->increment('stock', $difference);

            // Recalculate sale totals
            $sale = Sale::find($saleItem->sale_id);
            $subtotal = $sale->items->sum(fn($i) => $i->quantity * $i->unit_price);
            $discount = $sale->discount;
            $tax = $sale->tax;
            $total_price = max(($subtotal - $discount) + $tax, 0);
            $paid = $sale->paid_amount;
            $due = max($total_price - $paid, 0);
            $status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

            $sale->update([
                'subtotal' => $subtotal,
                'total_price' => $total_price,
                'due_amount' => $due,
                'payment_status' => $status,
            ]);
        });

        return response()->json(['message' => 'Sale item updated successfully']);
    }

    public function destroy(SaleItem $saleItem)
    {
        DB::transaction(function () use ($saleItem) {
            Product::where('id', $saleItem->product_id)->increment('stock', $saleItem->quantity);

            $saleId = $saleItem->sale_id;
            $saleItem->delete();

            $sale = Sale::find($saleId);
            if ($sale) {
                $subtotal = $sale->items->sum(fn($i) => $i->quantity * $i->unit_price);
                $discount = $sale->discount;
                $tax = $sale->tax;
                $total_price = max(($subtotal - $discount) + $tax, 0);
                $paid = $sale->paid_amount;
                $due = max($total_price - $paid, 0);
                $status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

                $sale->update([
                    'subtotal' => $subtotal,
                    'total_price' => $total_price,
                    'due_amount' => $due,
                    'payment_status' => $status,
                ]);
            }
        });

        return response()->json(['message' => 'Sale item deleted successfully']);
    }
}
