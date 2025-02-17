<?php

// database/migrations/2025_02_17_000002_create_especies_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEspeciesTable extends Migration
{
    public function up()
    {
        Schema::create('especies', function (Blueprint $table) {
            $table->id('especie_id');
            $table->string('nombre', 100)->unique();
            $table->string('clasificacion', 100)->nullable();
            $table->string('designacion', 100)->nullable();
            $table->decimal('altura_promedio', 5,2)->nullable();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('especies');
    }
}
