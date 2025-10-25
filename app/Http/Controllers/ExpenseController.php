
<?php

namespace App\Http\Controllers;

use App\Models\Expense;
use Illuminate\Http\Request;

class ExpenseController extends Controller
{
    public function index() {
        return response()->json(Expense::orderBy('expense_date', 'desc')->get());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'expense_date' => 'required|date',
            'category' => 'required|string',
            'amount' => 'required|numeric',
            'note' => 'nullable|string',
        ]);

        $expense = Expense::create($validated);
        return response()->json($expense, 201);
    }

    public function show(Expense $expense) {
        return response()->json($expense);
    }

    public function update(Request $request, Expense $expense) {
        $expense->update($request->all());
        return response()->json($expense);
    }

    public function destroy(Expense $expense) {
        $expense->delete();
        return response()->json(['message' => 'Expense deleted']);
    }
}
