<?php

// database/migrations/2025_02_17_000007_create_vehiculos_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVehiculosTable extends Migration
{
    public function up()
    {
        Schema::create('vehiculos', function (Blueprint $table) {
            $table->id('vehiculo_id');
            $table->string('nombre', 100)->unique();
            $table->string('modelo', 100)->nullable();
            $table->string('fabricante', 100)->nullable();
            $table->decimal('costo', 15,2)->nullable();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('vehiculos');
    }
}
