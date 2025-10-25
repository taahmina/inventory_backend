<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use Illuminate\Http\Request;

class EmployeeController extends Controller
{
    public function index() {
        return response()->json(Employee::all());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'required|email|unique:employees',
            'phone' => 'nullable|string',
            'address' => 'nullable|string',
            'position' => 'nullable|string',
            'salary' => 'numeric',
            'joining_date' => 'nullable|date',
        ]);
        $employee = Employee::create($validated);
        return response()->json($employee, 201);
    }

    public function show(Employee $employee) {
        return response()->json($employee);
    }

    public function update(Request $request, Employee $employee) {
        $employee->update($request->all());
        return response()->json($employee);
    }

    public function destroy(Employee $employee) {
        $employee->delete();
        return response()->json(['message' => 'Employee deleted']);
    }
}
