<?php



namespace App\Http\Controllers;

use App\Models\PurchaseItem;
use App\Models\Product;
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
            $oldQuantity = $purchaseItem->quantity;
            $oldUnitPrice = $purchaseItem->unit_price;

            $newQuantity = $validated['quantity'] ?? $oldQuantity;
            $newUnitPrice = $validated['unit_price'] ?? $oldUnitPrice;

            $purchaseItem->update([
                'quantity' => $newQuantity,
                'unit_price' => $newUnitPrice,
                'total_cost' => $newQuantity * $newUnitPrice,
            ]);

            // Update stock
            $difference = $newQuantity - $oldQuantity;
            Product::where('id', $purchaseItem->product_id)
                ->increment('stock', $difference);
        });

        $purchaseItem->load('product');

        return response()->json(['message' => 'Purchase item updated successfully', 'item' => $purchaseItem]);
    }

    public function destroy(PurchaseItem $purchaseItem)
    {
        DB::transaction(function () use ($purchaseItem) {
            Product::where('id', $purchaseItem->product_id)
                ->decrement('stock', $purchaseItem->quantity);

            $purchaseItem->delete();
        });

        return response()->json(['message' => 'Purchase item deleted successfully']);
    }
}
