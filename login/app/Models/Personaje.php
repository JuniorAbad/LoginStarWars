<?php

// app/Models/Personaje.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Personaje extends Model
{
    protected $primaryKey = 'personaje_id';
    protected $fillable = ['nombre', 'altura', 'peso', 'planeta_id'];

    public function planeta()
    {
        return $this->belongsTo(Planeta::class, 'planeta_id', 'planeta_id');
    }
    public function peliculas()
    {
        return $this->belongsToMany(Pelicula::class, 'personaje_pelicula', 'personaje_id', 'pelicula_id');
    }
    public function vehiculos()
    {
        return $this->belongsToMany(Vehiculo::class, 'personaje_vehiculo', 'personaje_id', 'vehiculo_id');
    }
    public function especies()
    {
        return $this->belongsToMany(Especie::class, 'personaje_especie', 'personaje_id', 'especie_id');
    }
}
