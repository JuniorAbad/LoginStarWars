<?php

// app/Models/Vehiculo.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Vehiculo extends Model
{
    protected $primaryKey = 'vehiculo_id';
    protected $fillable = ['nombre', 'modelo', 'fabricante', 'costo'];

    public function personajes()
    {
        return $this->belongsToMany(Personaje::class, 'personaje_vehiculo', 'vehiculo_id', 'personaje_id');
    }
}
