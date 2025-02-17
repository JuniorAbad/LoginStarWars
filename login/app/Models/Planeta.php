<?php

// app/Models/Planeta.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Planeta extends Model
{
    protected $primaryKey = 'planeta_id';
    protected $fillable = ['nombre', 'clima', 'terreno'];

    public function personajes()
    {
        return $this->hasMany(Personaje::class, 'planeta_id', 'planeta_id');
    }
    public function peliculas()
    {
        return $this->belongsToMany(Pelicula::class, 'pelicula_planeta', 'planeta_id', 'pelicula_id');
    }
}
