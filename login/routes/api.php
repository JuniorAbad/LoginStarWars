<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\SwapiController;

Route::post('/register', [AuthController::class, 'register']);
Route::post('/login', [AuthController::class, 'login']);

Route::middleware('auth:sanctum')->group(function() {
    Route::post('/logout', [AuthController::class, 'logout']);

    // Endpoints para consumir SWAPI
    Route::post('/swapi/personaje/{id}', [SwapiController::class, 'storePersonaje']);
    Route::post('/swapi/planeta/{id}', [SwapiController::class, 'storePlaneta']);
    Route::post('/swapi/pelicula/{id}', [SwapiController::class, 'storePelicula']);

    // Endpoint para obtener el historial de consultas
    Route::get('/historial', [SwapiController::class, 'historial']);
});
