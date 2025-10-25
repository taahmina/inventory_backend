<?php

namespace App\Http\Controllers;

use App\Models\Product;
use Illuminate\Http\Request;

class ProductController extends Controller
{
    public function index() {
        return response()->json(Product::with('category', 'supplier')->get());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'category_id' => 'required|exists:categories,id',
            'supplier_id' => 'required|exists:suppliers,id',
            'quantity' => 'required|numeric',
            'buy_price' => 'required|numeric',
            'sell_price' => 'required|numeric',
        ]);

        $product = Product::create($validated);
        return response()->json($product, 201);
    }

    public function show(Product $product) {
        return response()->json($product->load('category', 'supplier'));
    }

    public function update(Request $request, Product $product) {
        $product->update($request->all());
        return response()->json($product);
    }

    public function destroy(Product $product) {
        $product->delete();
        return response()->json(['message' => 'Product deleted']);
    }
}
