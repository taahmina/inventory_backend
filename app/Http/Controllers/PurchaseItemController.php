<?php

namespace App\Http\Controllers;

use App\Models\PurchaseItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PurchaseItemController extends Controller
{
    // Get all purchase items
    public function index()
    {
        $items = PurchaseItem::with(['purchase.supplier', 'product'])->latest()->get();
        return response()->json($items);
    }

    // Get a single purchase item
    public function show(PurchaseItem $purchaseItem)
    {
        return response()->json($purchaseItem->load(['purchase.supplier', 'product']));
    }

    // Update a purchase item (quantity / unit_price)
    public function update(Request $request, PurchaseItem $purchaseItem)
    {
        $validated = $request->validate([
            'quantity' => 'nullable|integer|min:1',
            'unit_price' => 'nullable|numeric|min:0',
        ]);

        DB::transaction(function () use ($purchaseItem, $validated) {
            $oldQuantity = $purchaseItem->quantity;
            $purchaseItem->update([
                'quantity' => $validated['quantity'] ?? $purchaseItem->quantity,
                'unit_price' => $validated['unit_price'] ?? $purchaseItem->unit_price,
                'total_cost' => ($validated['quantity'] ?? $purchaseItem->quantity) * ($validated['unit_price'] ?? $purchaseItem->unit_price)
            ]);

            // Update stock based on quantity difference
            $difference = ($validated['quantity'] ?? $purchaseItem->quantity) - $oldQuantity;
            Product::where('id', $purchaseItem->product_id)
                ->increment('stock_quantity', $difference);
        });

        return response()->json(['message' => 'Purchase item updated successfully', 'item' => $purchaseItem]);
    }

    // Delete a purchase item
    public function destroy(PurchaseItem $purchaseItem)
    {
        DB::transaction(function () use ($purchaseItem) {
            // Reduce stock before deleting
            Product::where('id', $purchaseItem->product_id)
                ->decrement('stock_quantity', $purchaseItem->quantity);

            $purchaseItem->delete();
        });

        return response()->json(['message' => 'Purchase item deleted successfully']);
    }
}
