<?php

namespace App\Http\Controllers;

use App\Models\Category;
use Illuminate\Http\Request;

class CategoryController extends Controller
{
    public function index() {
        return response()->json(Category::all());
    }

    public function store(Request $request) {
        $validated = $request->validate(['name' => 'required|string|max:255']);
        $category = Category::create($validated);
        return response()->json($category, 201);
    }

    public function show(Category $category) {
        return response()->json($category);
    }

    public function update(Request $request, Category $category) {
        $category->update($request->validate(['name' => 'required|string|max:255']));
        return response()->json($category);
    }

    public function destroy(Category $category) {
        $category->delete();
        return response()->json(['message' => 'Category deleted']);
    }
}
