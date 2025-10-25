<?php

namespace App\Http\Controllers;

use App\Models\Purchase;
use App\Models\Product;
use Illuminate\Http\Request;

class PurchaseController extends Controller
{
    public function index() {
        return response()->json(Purchase::with('product', 'supplier')->get());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'supplier_id' => 'required|exists:suppliers,id',
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|numeric|min:1',
            'unit_price' => 'required|numeric',
        ]);

        $validated['total_cost'] = $validated['quantity'] * $validated['unit_price'];
        $purchase = Purchase::create($validated);

        // Update stock
        $product = Product::find($validated['product_id']);
        $product->increment('quantity', $validated['quantity']);

        return response()->json($purchase, 201);
    }

    public function show(Purchase $purchase) {
        return response()->json($purchase->load('product', 'supplier'));
    }

    public function update(Request $request, Purchase $purchase) {
        $purchase->update($request->all());
        return response()->json($purchase);
    }

    public function destroy(Purchase $purchase) {
        $purchase->delete();
        return response()->json(['message' => 'Purchase deleted']);
    }
}
