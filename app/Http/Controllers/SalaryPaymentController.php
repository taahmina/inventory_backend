<?php

namespace App\Http\Controllers;

use App\Models\SalaryPayment;
use App\Models\Employee;
use App\Models\Expense;
use Illuminate\Http\Request;

class SalaryPaymentController extends Controller
{
    public function index() {
        return response()->json(SalaryPayment::with('employee')->get());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'employee_id' => 'required|exists:employees,id',
            'amount' => 'required|numeric',
            'pay_date' => 'nullable|date',
            'note' => 'nullable|string',
        ]);

        if (!isset($validated['pay_date'])) {
            $validated['pay_date'] = now();
        }

        $salaryPayment = SalaryPayment::create($validated);

        // Automatically create an expense entry for salary
        Expense::create([
            'expense_date' => $validated['pay_date'],
            'category' => 'Salary',
            'amount' => $validated['amount'],
            'note' => 'Salary paid to employee ID ' . $validated['employee_id'],
        ]);

        return response()->json($salaryPayment, 201);
    }

    public function show(SalaryPayment $salaryPayment) {
        return response()->json($salaryPayment->load('employee'));
    }

    public function update(Request $request, SalaryPayment $salaryPayment) {
        $salaryPayment->update($request->all());
        return response()->json($salaryPayment);
    }

    public function destroy(SalaryPayment $salaryPayment) {
        $salaryPayment->delete();
        return response()->json(['message' => 'Salary payment deleted']);
    }
}
