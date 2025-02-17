<?php

// database/migrations/2025_02_17_000006_create_historial_consultas_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateHistorialConsultasTable extends Migration
{
    public function up()
    {
        Schema::create('historial_consultas', function (Blueprint $table) {
            $table->id('historial_id');
            $table->unsignedBigInteger('usuario_id');
            $table->foreign('usuario_id')->references('usuario_id')->on('usuarios')->onDelete('cascade');
            $table->string('endpoint', 255);
            $table->json('params')->nullable();
            $table->timestamp('fecha')->useCurrent();
        });
    }
    public function down()
    {
        Schema::dropIfExists('historial_consultas');
    }
}
