<?php

namespace App\Http\Controllers;

use App\Models\Sale;
use App\Models\Product;
use Illuminate\Http\Request;

class SaleController extends Controller
{
    public function index() {
        return response()->json(Sale::with('product', 'customer')->get());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'customer_id' => 'required|exists:customers,id',
            'product_id' => 'required|exists:products,id',
            'quantity' => 'required|numeric|min:1',
            'total_price' => 'required|numeric',
        ]);

        $sale = Sale::create($validated);

        // Reduce stock
        $product = Product::find($validated['product_id']);
        $product->decrement('quantity', $validated['quantity']);

        return response()->json($sale, 201);
    }

    public function show(Sale $sale) {
        return response()->json($sale->load('product', 'customer'));
    }

    public function update(Request $request, Sale $sale) {
        $sale->update($request->all());
        return response()->json($sale);
    }

    public function destroy(Sale $sale) {
        $sale->delete();
        return response()->json(['message' => 'Sale deleted']);
    }
}
