<?php

// database/migrations/2025_02_17_000008_create_personaje_pelicula_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePersonajePeliculaTable extends Migration
{
    public function up()
    {
        Schema::create('personaje_pelicula', function (Blueprint $table) {
            $table->unsignedBigInteger('personaje_id');
            $table->unsignedBigInteger('pelicula_id');
            $table->primary(['personaje_id', 'pelicula_id']);
            $table->foreign('personaje_id')->references('personaje_id')->on('personajes')->onDelete('cascade');
            $table->foreign('pelicula_id')->references('pelicula_id')->on('peliculas')->onDelete('cascade');
        });
    }
    public function down()
    {
        Schema::dropIfExists('personaje_pelicula');
    }
}
