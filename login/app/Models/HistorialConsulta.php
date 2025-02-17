<?php

// app/Models/HistorialConsulta.php
namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class HistorialConsulta extends Model
{
    protected $table = 'historial_consultas';
    protected $primaryKey = 'historial_id';
    public $timestamps = false;
    protected $fillable = ['usuario_id', 'endpoint', 'params', 'fecha'];
}
