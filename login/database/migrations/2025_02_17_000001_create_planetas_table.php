<?php

// database/migrations/2025_02_17_000001_create_planetas_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlanetasTable extends Migration
{
    public function up()
    {
        Schema::create('planetas', function (Blueprint $table) {
            $table->id('planeta_id');
            $table->string('nombre', 100)->unique();
            $table->string('clima', 100)->nullable();
            $table->string('terreno', 100)->nullable();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('planetas');
    }
}
