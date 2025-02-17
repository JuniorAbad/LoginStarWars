<?php

// app/Models/Pelicula.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pelicula extends Model
{
    protected $primaryKey = 'pelicula_id';
    protected $fillable = ['titulo', 'director', 'fecha_estreno'];

    public function personajes()
    {
        return $this->belongsToMany(Personaje::class, 'personaje_pelicula', 'pelicula_id', 'personaje_id');
    }
    public function planetas()
    {
        return $this->belongsToMany(Planeta::class, 'pelicula_planeta', 'pelicula_id', 'planeta_id');
    }
}
