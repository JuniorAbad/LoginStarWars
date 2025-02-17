<?php

// database/migrations/2025_02_17_000005_create_usuarios_table.php
use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateUsuariosTable extends Migration
{
    public function up()
    {
        Schema::create('usuarios', function (Blueprint $table) {
            $table->id('usuario_id');
            $table->string('nombre_usuario', 100)->unique();
            $table->string('contraseña_hash', 255);
            $table->string('email', 100)->unique();
            $table->timestamps();
        });
    }
    public function down()
    {
        Schema::dropIfExists('usuarios');
    }
}
