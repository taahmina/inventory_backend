
<?php

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Api\UserAuthController;
use App\Http\Controllers\{
    CategoryController,
    SupplierController,
    ProductController,
    CustomerController,
    EmployeeController,
    PurchaseController,
    SaleController,
    ExpenseController,
    SalaryPaymentController
};

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/
Route::post('register',[UserAuthController::class,'register']);
Route::post('login',[UserAuthController::class,'login']);
Route::post('logout',[UserAuthController::class,'logout'])->middleware('auth:sanctum');

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});






// ------------------------
// Category Routes
// ------------------------
Route::apiResource('categories', CategoryController::class);

// ------------------------
// Supplier Routes
// ------------------------
Route::apiResource('suppliers', SupplierController::class);

// ------------------------
// Product Routes
// ------------------------
Route::apiResource('products', ProductController::class);

// ------------------------
// Customer Routes
// ------------------------
Route::apiResource('customers', CustomerController::class);

// ------------------------
// Employee Routes
// ------------------------
Route::apiResource('employees', EmployeeController::class);

// ------------------------
// Purchase Routes
// ------------------------
Route::apiResource('purchases', PurchaseController::class);

// ------------------------
// Sale Routes
// ------------------------
Route::apiResource('sales', SaleController::class);

// ------------------------
// Expense Routes
// ------------------------
Route::apiResource('expenses', ExpenseController::class);

// ------------------------
// Salary Payment Routes
// ------------------------
Route::apiResource('salary-payments', SalaryPaymentController::class);
