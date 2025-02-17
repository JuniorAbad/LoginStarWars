<?php

// database/migrations/2025_02_17_000003_create_peliculas_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePeliculasTable extends Migration
{
    public function up()
    {
        Schema::create('peliculas', function (Blueprint $table) {
            $table->id('pelicula_id');
            $table->string('titulo', 100)->unique();
            $table->string('director', 100)->nullable();
            $table->date('fecha_estreno')->nullable();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('peliculas');
    }
}
