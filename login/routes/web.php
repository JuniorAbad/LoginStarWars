<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;

// Ruta para registro de usuario
Route::post('/register', [AuthController::class, 'register']);

// Ruta para inicio de sesión
Route::post('/login', [AuthController::class, 'login']);

// Ruta para cierre de sesión
// Es recomendable proteger esta ruta con middleware de autenticación, por ejemplo 'auth' o 'auth:sanctum'
Route::post('/logout', [AuthController::class, 'logout'])->middleware('auth:sanctum');