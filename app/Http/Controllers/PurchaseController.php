<?php

namespace App\Http\Controllers;

use App\Models\Purchase;
use App\Models\Product;
use App\Models\PurchaseItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class PurchaseController extends Controller
{
    public function index()
    {
        // Return all purchases with supplier and their items
        $purchases = Purchase::with(['supplier', 'items.product'])->latest()->get();
        return response()->json($purchases);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'supplier_id' => 'required|exists:suppliers,id',
            'purchase_date' => 'required|date',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.unit_price' => 'required|numeric|min:0',
            'discount' => 'nullable|numeric|min:0',
            'tax' => 'nullable|numeric|min:0',
            'paid_amount' => 'nullable|numeric|min:0',
            'note' => 'nullable|string'
        ]);

        DB::transaction(function () use ($validated) {
            // Generate unique invoice
            $invoice_no = 'PUR-' . now()->format('YmdHis');

            // Calculate subtotal
            $subtotal = collect($validated['items'])->sum(function ($item) {
                return $item['quantity'] * $item['unit_price'];
            });

            $discount = $validated['discount'] ?? 0;
            $tax = $validated['tax'] ?? 0;
            $total_cost = ($subtotal - $discount) + $tax;
            $paid = $validated['paid_amount'] ?? 0;
            $due = $total_cost - $paid;

            // Create main purchase
            $purchase = Purchase::create([
                'supplier_id' => $validated['supplier_id'],
                'invoice_no' => $invoice_no,
                'purchase_date' => $validated['purchase_date'],
                'subtotal' => $subtotal,
                'discount' => $discount,
                'tax' => $tax,
                'total_cost' => $total_cost,
                'paid_amount' => $paid,
                'due_amount' => $due,
                'payment_status' => $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due'),
                'note' => $validated['note'] ?? null,
            ]);

            // Insert purchase items + update stock
            foreach ($validated['items'] as $item) {
                $lineTotal = $item['quantity'] * $item['unit_price'];

                PurchaseItem::create([
                    'purchase_id' => $purchase->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['unit_price'],
                    'total_cost' => $lineTotal,
                ]);

                // Increase product stock
                Product::where('id', $item['product_id'])
                    ->increment('stock_quantity', $item['quantity']);
            }
        });

        return response()->json(['message' => 'Purchase created successfully'], 201);
    }

    public function show(Purchase $purchase)
    {
        return response()->json($purchase->load(['supplier', 'items.product']));
    }

    public function update(Request $request, Purchase $purchase)
    {
        $purchase->update($request->only(['paid_amount', 'payment_status', 'note']));
        return response()->json(['message' => 'Purchase updated', 'purchase' => $purchase]);
    }

    public function destroy(Purchase $purchase)
    {
        DB::transaction(function () use ($purchase) {
            // Reverse stock quantities before deleting
            foreach ($purchase->items as $item) {
                Product::where('id', $item->product_id)
                    ->decrement('stock_quantity', $item->quantity);
            }

            $purchase->items()->delete();
            $purchase->delete();
        });

        return response()->json(['message' => 'Purchase deleted successfully']);
    }
}
