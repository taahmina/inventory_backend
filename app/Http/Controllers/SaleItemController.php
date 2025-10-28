<?php

namespace App\Http\Controllers;

use App\Models\SaleItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SaleItemController extends Controller
{
    // List all sale items (optional, for admin view)
    public function index()
    {
        $items = SaleItem::with(['sale.customer', 'product'])->latest()->get();
        return response()->json($items);
    }

    // Show single sale item
    public function show(SaleItem $saleItem)
    {
        return response()->json($saleItem->load(['sale.customer', 'product']));
    }

    // Update sale item (quantity or unit price)
    public function update(Request $request, SaleItem $saleItem)
    {
        $validated = $request->validate([
            'quantity' => 'nullable|integer|min:1',
            'unit_price' => 'nullable|numeric|min:0',
        ]);

        DB::transaction(function () use ($saleItem, $validated) {
            $oldQuantity = $saleItem->quantity;
            $oldUnitPrice = $saleItem->unit_price;

            $newQuantity = $validated['quantity'] ?? $oldQuantity;
            $newUnitPrice = $validated['unit_price'] ?? $oldUnitPrice;

            // Update item
            $saleItem->update([
                'quantity' => $newQuantity,
                'unit_price' => $newUnitPrice,
                'total_cost' => $newQuantity * $newUnitPrice,
            ]);

            // Update stock
            $difference = $oldQuantity - $newQuantity; // if quantity decreased, return stock
            Product::where('id', $saleItem->product_id)
                ->increment('stock', $difference);
        });

        $saleItem->load('product');

        return response()->json([
            'message' => 'Sale item updated successfully',
            'item' => $saleItem
        ]);
    }

    // Delete sale item
    public function destroy(SaleItem $saleItem)
    {
        DB::transaction(function () use ($saleItem) {
            // Restore stock
            Product::where('id', $saleItem->product_id)
                ->increment('stock', $saleItem->quantity);

            $saleItem->delete();
        });

        return response()->json(['message' => 'Sale item deleted successfully']);
    }
}
