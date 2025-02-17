<?php

// app/Models/Especie.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Especie extends Model
{
    protected $primaryKey = 'especie_id';
    protected $fillable = ['nombre', 'clasificacion', 'designacion', 'altura_promedio'];

    public function personajes()
    {
        return $this->belongsToMany(Personaje::class, 'personaje_especie', 'especie_id', 'personaje_id');
    }
}
