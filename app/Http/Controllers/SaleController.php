<?php

namespace App\Http\Controllers;

use App\Models\Sale;
use App\Models\SaleItem;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SaleController extends Controller
{
    // List all sales
    public function index()
    {
        $sales = Sale::with(['customer', 'items.product'])->latest()->get();
        return response()->json($sales);
    }

    // Store a new sale
    public function store(Request $request)
    {
        $validated = $request->validate([
            'customer_id' => 'required|exists:customers,id',
            'sale_date' => 'required|date',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'items.*.unit_price' => 'required|numeric|min:0',
            'discount' => 'nullable|numeric|min:0',
            'tax' => 'nullable|numeric|min:0',
            'paid_amount' => 'nullable|numeric|min:0',
            'note' => 'nullable|string'
        ]);

        $sale = DB::transaction(function () use ($validated) {
            $invoice_no = 'INV-' . now()->format('YmdHis');

            $subtotal = collect($validated['items'])->sum(function ($item) {
                return $item['quantity'] * $item['unit_price'];
            });

            $discount = $validated['discount'] ?? 0;
            $tax = $validated['tax'] ?? 0;
            $total_price = max(($subtotal - $discount) + $tax, 0);
            $paid = $validated['paid_amount'] ?? 0;
            $due = max($total_price - $paid, 0);
            $payment_status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

            $sale = Sale::create([
                'customer_id' => $validated['customer_id'],
                'invoice_no' => $invoice_no,
                'sale_date' => $validated['sale_date'],
                'subtotal' => $subtotal,
                'discount' => $discount,
                'tax' => $tax,
                'total_price' => $total_price,
                'paid_amount' => $paid,
                'due_amount' => $due,
                'payment_status' => $payment_status,
                'note' => $validated['note'] ?? null,
            ]);

            foreach ($validated['items'] as $item) {
                $lineTotal = $item['quantity'] * $item['unit_price'];

                SaleItem::create([
                    'sale_id' => $sale->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['unit_price'],
                    'total_cost' => $lineTotal
                ]);

                // Decrease stock
                Product::where('id', $item['product_id'])->decrement('stock', $item['quantity']);
            }

            return $sale;
        });

        return response()->json(['message' => 'Sale created successfully', 'sale' => $sale]);
    }

    // Show single sale
    public function show(Sale $sale)
    {
        return response()->json($sale->load(['customer', 'items.product']));
    }

    // Update sale (discount, tax, payment, note)
    public function update(Request $request, Sale $sale)
    {
        $validated = $request->validate([
            'discount' => 'nullable|numeric|min:0',
            'tax' => 'nullable|numeric|min:0',
            'paid_amount' => 'nullable|numeric|min:0',
            'note' => 'nullable|string'
        ]);

        $subtotal = $sale->items->sum(fn($item) => $item->quantity * $item->unit_price);
        $discount = $validated['discount'] ?? $sale->discount;
        $tax = $validated['tax'] ?? $sale->tax;
        $total_price = max(($subtotal - $discount) + $tax, 0);
        $paid = $validated['paid_amount'] ?? $sale->paid_amount;
        $due = max($total_price - $paid, 0);
        $payment_status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

        $sale->update([
            'subtotal' => $subtotal,
            'discount' => $discount,
            'tax' => $tax,
            'total_price' => $total_price,
            'paid_amount' => $paid,
            'due_amount' => $due,
            'payment_status' => $payment_status,
            'note' => $validated['note'] ?? $sale->note
        ]);

        return response()->json(['message' => 'Sale updated successfully', 'sale' => $sale]);
    }

    // Delete sale
    public function destroy(Sale $sale)
    {
        DB::transaction(function () use ($sale) {
            foreach ($sale->items as $item) {
                Product::where('id', $item->product_id)->increment('stock', $item->quantity);
            }

            $sale->items()->delete();
            $sale->delete();
        });

        return response()->json(['message' => 'Sale deleted successfully']);
    }
}
