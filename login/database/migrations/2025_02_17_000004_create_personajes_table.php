<?php

// database/migrations/2025_02_17_000004_create_personajes_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePersonajesTable extends Migration
{
    public function up()
    {
        Schema::create('personajes', function (Blueprint $table) {
            $table->id('personaje_id');
            $table->string('nombre', 100)->unique();
            $table->decimal('altura', 5,2)->nullable();
            $table->decimal('peso', 5,2)->nullable();
            $table->unsignedBigInteger('planeta_id')->nullable();
            $table->foreign('planeta_id')->references('planeta_id')->on('planetas')->onDelete('set null');
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('personajes');
    }
}
