<?php

namespace App\Http\Controllers;

use App\Models\Sale;
use App\Models\SaleItem;
use App\Models\Expense;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ReportController extends Controller
{
    /**
     * Sales Report
     * Optionally, filter by date range using request params: start_date, end_date
     */
    public function salesReport(Request $request)
    {
        $query = Sale::with(['items.product', 'customer']);

        if ($request->start_date && $request->end_date) {
            $query->whereBetween('sale_date', [$request->start_date, $request->end_date]);
        }

        $sales = $query->get();

        // Total sales amount
        $totalSales = $sales->sum('total_price');

        // Best-selling products
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
     * Optionally, filter by date range using request params: start_date, end_date
     */
    public function expenseReport(Request $request)
    {
        $query = Expense::query();

        if ($request->start_date && $request->end_date) {
            $query->whereBetween('expense_date', [$request->start_date, $request->end_date]);
        }

        $expenses = $query->get();

        // Total expenses
        $totalExpenses = $expenses->sum('amount');

        // Expenses by category
        $expensesByCategory = $expenses->groupBy('category')
            ->map(function ($group) {
                return $group->sum('amount');
            });

        return response()->json([
            'total_expenses' => $totalExpenses,
            'expenses' => $expenses,
            'expenses_by_category' => $expensesByCategory,
        ]);
    }

    /**
     * Profit & Loss Report
     * Optionally, filter by date range using request params: start_date, end_date
     */
    public function profitLossReport(Request $request)
    {
        $salesQuery = Sale::query();
        $expenseQuery = Expense::query();

        if ($request->start_date && $request->end_date) {
            $salesQuery->whereBetween('sale_date', [$request->start_date, $request->end_date]);
            $expenseQuery->whereBetween('expense_date', [$request->start_date, $request->end_date]);
        }

        $totalSales = $salesQuery->sum('total_price');
        $totalExpenses = $expenseQuery->sum('amount');
        $profit = $totalSales - $totalExpenses;

        return response()->json([
            'total_sales' => $totalSales,
            'total_expenses' => $totalExpenses,
            'profit' => $profit,
        ]);
    }

    /**
     * Inventory Report
     * Low stock alert and stock value
     */
    public function inventoryReport(Request $request)
    {
        $products = Product::all();

        $lowStockThreshold = $request->low_stock_threshold ?? 5;

        $lowStock = $products->filter(fn($p) => $p->stock <= $lowStockThreshold);

        $stockValue = $products->sum(function ($p) {
            return $p->stock * $p->buy_price;
        });

        return response()->json([
            'products' => $products,
            'low_stock' => $lowStock,
            'total_stock_value' => $stockValue,
        ]);
    }
}
