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

        $purchase = DB::transaction(function() use ($validated) {
            $invoice_no = 'PUR-' . now()->format('YmdHis');

            // Calculate subtotal
            $subtotal = collect($validated['items'])->sum(function ($item) {
                return $item['quantity'] * $item['unit_price'];
            });

            $discount = $validated['discount'] ?? 0;
            $tax = $validated['tax'] ?? 0;
            $total_cost = max(($subtotal - $discount) + $tax, 0); // avoid negative

            $paid = $validated['paid_amount'] ?? 0;
            $due = max($total_cost - $paid, 0);

            $payment_status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

            // Create purchase
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
                'payment_status' => $payment_status,
                'note' => $validated['note'] ?? null,
            ]);

            // Create purchase items and update stock
            foreach ($validated['items'] as $item) {
                $lineTotal = $item['quantity'] * $item['unit_price'];
                PurchaseItem::create([
                    'purchase_id' => $purchase->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['unit_price'],
                    'total_cost' => $lineTotal
                ]);

                // Increase product stock
                Product::where('id', $item['product_id'])
                    ->increment('stock', $item['quantity']);
            }

            return $purchase;
        });

        return response()->json(['message' => 'Purchase created successfully', 'purchase' => $purchase]);
    }

    public function show(Purchase $purchase)
    {
        return response()->json($purchase->load(['supplier', 'items.product']));
    }

    public function update(Request $request, Purchase $purchase)
    {
        $validated = $request->validate([
            'discount' => 'nullable|numeric|min:0',
            'tax' => 'nullable|numeric|min:0',
            'paid_amount' => 'nullable|numeric|min:0',
            'note' => 'nullable|string'
        ]);

        // Recalculate totals
        $subtotal = $purchase->items->sum(function($item){
            return $item->quantity * $item->unit_price;
        });
        $discount = $validated['discount'] ?? $purchase->discount;
        $tax = $validated['tax'] ?? $purchase->tax;
        $total_cost = max(($subtotal - $discount) + $tax, 0);
        $paid = $validated['paid_amount'] ?? $purchase->paid_amount;
        $due = max($total_cost - $paid, 0);
        $payment_status = $due <= 0 ? 'paid' : ($paid > 0 ? 'partial' : 'due');

        $purchase->update([
            'subtotal' => $subtotal,
            'discount' => $discount,
            'tax' => $tax,
            'total_cost' => $total_cost,
            'paid_amount' => $paid,
            'due_amount' => $due,
            'payment_status' => $payment_status,
            'note' => $validated['note'] ?? $purchase->note,
        ]);

        return response()->json(['message' => 'Purchase updated', 'purchase' => $purchase]);
    }

    public function destroy(Purchase $purchase)
    {
        DB::transaction(function () use ($purchase) {
            foreach ($purchase->items as $item) {
                Product::where('id', $item->product_id)
                    ->decrement('stock', $item->quantity);
            }

            $purchase->items()->delete();
            $purchase->delete();
        });

        return response()->json(['message' => 'Purchase deleted successfully']);
    }
}
