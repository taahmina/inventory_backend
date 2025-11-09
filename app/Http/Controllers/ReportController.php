<?php

namespace App\Http\Controllers;

use App\Models\Sale;
use App\Models\SaleItem;
use App\Models\Expense;
use App\Models\Product;
use App\Models\Purchase;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReportController extends Controller
{
    /**
     * Sales Report
     */
    public function salesReport(Request $request)
    {
        $query = Sale::with(['items.product', 'customer']);

        if ($request->start_date && $request->end_date) {
            $query->whereBetween('sale_date', [$request->start_date, $request->end_date]);
        }

        $sales = $query->get();
        $totalSales = $sales->sum('total_price');

        $bestSelling = SaleItem::select('product_id', DB::raw('SUM(quantity) as total_qty'))
            ->groupBy('product_id')
            ->orderByDesc('total_qty')
            ->with('product')
            ->get();

        return response()->json([
            'total_sales' => $totalSales,
            'sales' => $sales,
            'best_selling_products' => $bestSelling,
        ]);
    }

    /**
     * Expense Report
     */
    public function expenseReport(Request $request)
    {
        $query = Expense::query();

        if ($request->start_date && $request->end_date) {
            $query->whereBetween('expense_date', [$request->start_date, $request->end_date]);
        }

        $expenses = $query->get();
        $totalExpenses = $expenses->sum('amount');

        $expensesByCategory = $expenses->groupBy('category')
            ->map(fn($group) => $group->sum('amount'));

        return response()->json([
            'total_expenses' => $totalExpenses,
            'expenses' => $expenses,
            'expenses_by_category' => $expensesByCategory,
        ]);
    }

    /**
     * ✅ Profit & Loss Report (with daily breakdown and total purchase)
     */
    public function profitLossReport(Request $request)
    {
        $salesQuery = Sale::query();
        $purchaseQuery = Purchase::query();
        $expenseQuery = Expense::query();

        if ($request->start_date && $request->end_date) {
            $salesQuery->whereBetween('sale_date', [$request->start_date, $request->end_date]);
            $purchaseQuery->whereBetween('purchase_date', [$request->start_date, $request->end_date]);
            $expenseQuery->whereBetween('expense_date', [$request->start_date, $request->end_date]);
        }

        // Group sales, purchases, expenses by date
        $sales = $salesQuery->select(
            DB::raw('DATE(sale_date) as date'),
            DB::raw('SUM(total_price) as total_sales')
        )->groupBy('date')->get();

        $purchases = $purchaseQuery->select(
            DB::raw('DATE(purchase_date) as date'),
            DB::raw('SUM(total_cost) as total_purchase')
        )->groupBy('date')->get();

        $expenses = $expenseQuery->select(
            DB::raw('DATE(expense_date) as date'),
            DB::raw('SUM(amount) as total_expenses')
        )->groupBy('date')->get();

        // Merge by all unique dates
        $dates = collect(array_unique(array_merge(
            $sales->pluck('date')->toArray(),
            $purchases->pluck('date')->toArray(),
            $expenses->pluck('date')->toArray()
        )))->sort();

        $report = [];
        foreach ($dates as $date) {
            $totalSales = $sales->firstWhere('date', $date)?->total_sales ?? 0;
            $totalPurchase = $purchases->firstWhere('date', $date)?->total_purchase ?? 0;
            $totalExpenses = $expenses->firstWhere('date', $date)?->total_expenses ?? 0;

            $grossProfit = $totalSales - $totalPurchase;
            $netProfit = $grossProfit - $totalExpenses;

            $report[] = [
                'date' => $date,
                'total_sales' => $totalSales,
                'total_purchase_cost' => $totalPurchase,
                'total_expenses' => $totalExpenses,
                'gross_profit' => $grossProfit,
                'net_profit' => $netProfit,
            ];
        }

        // Add overall totals row
        $totalSales = $sales->sum('total_sales');
        $totalPurchase = $purchases->sum('total_purchase');
        $totalExpenses = $expenses->sum('total_expenses');
        $grossProfit = $totalSales - $totalPurchase;
        $netProfit = $grossProfit - $totalExpenses;

        $report[] = [
            'date' => null,
            'total_sales' => $totalSales,
            'total_purchase_cost' => $totalPurchase,
            'total_expenses' => $totalExpenses,
            'gross_profit' => $grossProfit,
            'net_profit' => $netProfit,
        ];

        return response()->json($report);
    }

    /**
     * Inventory Report
     */
    public function inventoryReport(Request $request)
    {
        $products = Product::all();
        $lowStockThreshold = $request->low_stock_threshold ?? 5;

        $lowStock = $products->filter(fn($p) => $p->stock <= $lowStockThreshold);

        $stockValue = $products->sum(fn($p) => $p->stock * $p->buy_price);

        return response()->json([
            'products' => $products,
            'low_stock' => $lowStock,
            'total_stock_value' => $stockValue,
        ]);
    }
}
