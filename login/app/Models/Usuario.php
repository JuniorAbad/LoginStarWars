<?php

// app/Models/Usuario.php
namespace App\Models;

use Illuminate\Foundation\Auth\User as Authenticatable;
use Laravel\Sanctum\HasApiTokens;

class Usuario extends Authenticatable
{
    use HasApiTokens;
    
    protected $table = 'usuarios';
    protected $primaryKey = 'usuario_id';
    protected $fillable = ['nombre_usuario', 'contraseña_hash', 'email'];
    protected $hidden = ['contraseña_hash'];

    public function getAuthPassword()
    {
        return $this->contraseña_hash;
    }
}
