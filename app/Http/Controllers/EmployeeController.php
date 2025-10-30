<?php

namespace App\Http\Controllers;

use App\Models\Employee;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class EmployeeController extends Controller
{
    public function index()
    {
        $employees = Employee::latest()->get();
        return response()->json($employees);
    }

    public function store(Request $request)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|unique:employees,email',
            'phone' => 'nullable|string|max:20',
            'username' => 'nullable|string|unique:employees,username',
            'password' => 'nullable|string|min:6',
            'profile_photo' => 'nullable|string',
            'address' => 'nullable|string',
            'position' => 'nullable|string',
            'salary' => 'nullable|numeric',
            'joining_date' => 'nullable|date',
            'termination_date' => 'nullable|date',
            'notes' => 'nullable|string',
            'status' => 'nullable|boolean',
        ]);

        if (!empty($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        }

        $employee = Employee::create($validated);

        return response()->json(['message' => 'Employee created successfully', 'employee' => $employee]);
    }

    public function show(Employee $employee)
    {
        return response()->json($employee);
    }

    public function update(Request $request, Employee $employee)
    {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email|unique:employees,email,' . $employee->id,
            'phone' => 'nullable|string|max:20',
            'username' => 'nullable|string|unique:employees,username,' . $employee->id,
            'password' => 'nullable|string|min:6',
            'profile_photo' => 'nullable|string',
            'address' => 'nullable|string',
            'position' => 'nullable|string',
            'salary' => 'nullable|numeric',
            'joining_date' => 'nullable|date',
            'termination_date' => 'nullable|date',
            'notes' => 'nullable|string',
            'status' => 'nullable|boolean',
        ]);

        if (!empty($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        } else {
            unset($validated['password']); // keep existing password
        }

        $employee->update($validated);

        return response()->json(['message' => 'Employee updated successfully', 'employee' => $employee]);
    }

    public function destroy(Employee $employee)
    {
        $employee->delete();
        return response()->json(['message' => 'Employee deleted successfully']);
    }
}
