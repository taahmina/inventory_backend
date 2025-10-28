<?php

namespace App\Http\Controllers;

use App\Models\PurchaseItem;
use App\Models\Product;
use App\Models\Purchase;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PurchaseItemController extends Controller
{
    public function index()
    {
        $items = PurchaseItem::with(['purchase.supplier', 'product'])->latest()->get();
        return response()->json($items);
    }

    public function show(PurchaseItem $purchaseItem)
    {
        return response()->json($purchaseItem->load(['purchase.supplier', 'product']));
    }

    public function update(Request $request, PurchaseItem $purchaseItem)
    {
        $validated = $request->validate([
            'quantity' => 'nullable|integer|min:1',
            'unit_price' => 'nullable|numeric|min:0',
        ]);

        DB::transaction(function () use ($purchaseItem, $validated) {
            $oldQty = $purchaseItem->quantity;
            $oldPrice = $purchaseItem->unit_price;

            $newQty = $validated['quantity'] ?? $oldQty;
            $newPrice = $validated['unit_price'] ?? $oldPrice;

            $purchaseItem->update([
                'quantity' => $newQty,
                'unit_price' => $newPrice,
                'total_cost' => $newQty * $newPrice,
            ]);

            // Update stock
            $difference = $newQty - $oldQty;
            Product::where('id', $purchaseItem->product_id)->increment('stock', $difference);

            // Recalculate purchase totals
            $purchase = Purchase::find($purchaseItem->purchase_id);
            $subtotal = $purchase->items->sum(fn($i) => $i->quantity * $i->unit_price);
            $discount = $purchase->discount;
            $tax = $purchase->tax;
            $total_cost = max(($subtotal - $discount) + $tax, 0);
            $paid = $purchase->paid_amount;
            $due = max($total_cost - $paid, 0);
            $status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

            $purchase->update([
                'subtotal' => $subtotal,
                'total_cost' => $total_cost,
                'due_amount' => $due,
                'payment_status' => $status,
            ]);
        });

        return response()->json(['message' => 'Purchase item updated successfully']);
    }

    public function destroy(PurchaseItem $purchaseItem)
    {
        DB::transaction(function () use ($purchaseItem) {
            Product::where('id', $purchaseItem->product_id)->decrement('stock', $purchaseItem->quantity);

            $purchaseId = $purchaseItem->purchase_id;
            $purchaseItem->delete();

            // Recalculate totals after delete
            $purchase = Purchase::find($purchaseId);
            if ($purchase) {
                $subtotal = $purchase->items->sum(fn($i) => $i->quantity * $i->unit_price);
                $discount = $purchase->discount;
                $tax = $purchase->tax;
                $total_cost = max(($subtotal - $discount) + $tax, 0);
                $paid = $purchase->paid_amount;
                $due = max($total_cost - $paid, 0);
                $status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

                $purchase->update([
                    'subtotal' => $subtotal,
                    'total_cost' => $total_cost,
                    'due_amount' => $due,
                    'payment_status' => $status,
                ]);
            }
        });

        return response()->json(['message' => 'Purchase item deleted successfully']);
    }
}
