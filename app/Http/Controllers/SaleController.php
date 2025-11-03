<?php

namespace App\Http\Controllers;

use App\Models\Sale;
use App\Models\Product;
use App\Models\SaleItem;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SaleController extends Controller
{
    public function index()
    {
        $sales = Sale::with(['customer', 'items.product'])->latest()->get();
        return response()->json($sales);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'customer_id' => 'required|exists:customers,id',
            'sale_date' => 'required|date',
            'items' => 'required|array|min:1',
            'items.*.product_id' => 'required|exists:products,id',
            'items.*.quantity' => 'required|integer|min:1',
            'discount' => 'nullable|numeric|min:0',
            'tax' => 'nullable|numeric|min:0',
            'paid_amount' => 'nullable|numeric|min:0',
            'note' => 'nullable|string'
        ]);

        $sale = DB::transaction(function () use ($validated) {
            $invoice_no = 'SAL-' . now()->format('YmdHis');

            // Automatically use product's sell_price as unit_price
            $itemsData = collect($validated['items'])->map(function ($item) {
                $product = Product::findOrFail($item['product_id']);
                $item['unit_price'] = $product->sell_price;
                return $item;
            });

            $subtotal = $itemsData->sum(fn($i) => $i['quantity'] * $i['unit_price']);
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

            foreach ($itemsData as $item) {
                $lineTotal = $item['quantity'] * $item['unit_price'];

                SaleItem::create([
                    'sale_id' => $sale->id,
                    'product_id' => $item['product_id'],
                    'quantity' => $item['quantity'],
                    'unit_price' => $item['unit_price'],
                    'total_price' => $lineTotal,
                ]);

                // Decrease stock when selling
                Product::where('id', $item['product_id'])->decrement('stock', $item['quantity']);
            }

            return $sale->load(['customer', 'items.product']);
        });

        return response()->json(['message' => 'Sale created successfully', 'sale' => $sale]);
    }

    public function show(Sale $sale)
    {
        return response()->json($sale->load(['customer', 'items.product']));
    }

    public function update(Request $request, Sale $sale)
    {
        $validated = $request->validate([
            'discount' => 'nullable|numeric|min:0',
            'tax' => 'nullable|numeric|min:0',
            'paid_amount' => 'nullable|numeric|min:0',
            'note' => 'nullable|string'
        ]);

        DB::transaction(function () use ($sale, $validated) {
            $subtotal = $sale->items->sum(fn($i) => $i->quantity * $i->unit_price);
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
                'note' => $validated['note'] ?? $sale->note,
            ]);
        });

        return response()->json(['message' => 'Sale updated successfully', 'sale' => $sale->fresh(['customer', 'items.product'])]);
    }

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

    public function invoice($id)
{
    $sale = Sale::with(['customer', 'items.product'])->findOrFail($id);

    return response()->json([
        'sale' => $sale
    ]);
}

}
