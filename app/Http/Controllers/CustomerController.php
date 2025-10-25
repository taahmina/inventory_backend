<?php

namespace App\Http\Controllers;

use App\Models\Customer;
use Illuminate\Http\Request;

class CustomerController extends Controller
{
    public function index() {
        return response()->json(Customer::all());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'name' => 'required|string',
            'email' => 'nullable|email',
            'phone' => 'nullable|string',
            'address' => 'nullable|string',
        ]);

        $customer = Customer::create($validated);
        return response()->json($customer, 201);
    }

    public function show(Customer $customer) {
        return response()->json($customer);
    }

    public function update(Request $request, Customer $customer) {
        $customer->update($request->all());
        return response()->json($customer);
    }

    public function destroy(Customer $customer) {
        $customer->delete();
        return response()->json(['message' => 'Customer deleted']);
    }
}
