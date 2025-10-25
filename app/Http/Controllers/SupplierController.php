<?php

namespace App\Http\Controllers;

use App\Models\Supplier;
use Illuminate\Http\Request;

class SupplierController extends Controller
{
    public function index() {
        return response()->json(Supplier::all());
    }

    public function store(Request $request) {
        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'nullable|email',
            'phone' => 'nullable|string|max:20',
            'address' => 'nullable|string',
        ]);
        $supplier = Supplier::create($validated);
        return response()->json($supplier, 201);
    }

    public function show(Supplier $supplier) {
        return response()->json($supplier);
    }

    public function update(Request $request, Supplier $supplier) {
        $supplier->update($request->all());
        return response()->json($supplier);
    }

    public function destroy(Supplier $supplier) {
        $supplier->delete();
        return response()->json(['message' => 'Supplier deleted']);
    }
}
