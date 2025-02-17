<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Cache;
use App\Models\Personaje;
use App\Models\Planeta;
use App\Models\Pelicula;
use App\Models\Vehiculo;
use App\Models\Especie;
use App\Models\HistorialConsulta;

class SwapiController extends Controller
{
    protected $baseUrl = 'https://swapi.dev/api/';

    // Función auxiliar para registrar el historial de consultas
    protected function logConsulta($usuarioId, $endpoint, $params = [])
    {
        HistorialConsulta::create([
            'usuario_id' => $usuarioId,
            'endpoint'   => $endpoint,
            'params'     => json_encode($params)
        ]);
    }

    // Obtener y almacenar un personaje
    public function storePersonaje(Request $request, $id)
    {
        $cacheKey = 'swapi_personaje_' . $id;

        if(Cache::has($cacheKey)) {
            $data = Cache::get($cacheKey);
            return response()->json(['from_cache' => true, 'data' => $data]);
        }

        $response = Http::get($this->baseUrl . "people/{$id}/");

        if ($response->failed()) {
            return response()->json(['error' => 'No se encontró el personaje'], 404);
        }

        $data = $response->json();

        // Crear/actualizar personaje
        $personaje = Personaje::updateOrCreate(
            ['nombre' => $data['name']],
            [
                'altura' => $data['height'] ?? null,
                'peso'   => $data['mass'] ?? null,
            ]
        );

        // Relacionar con su planeta
        if(isset($data['homeworld'])) {
            $planetaResponse = Http::get($data['homeworld']);
            if($planetaResponse->successful()){
                $planetaData = $planetaResponse->json();
                $planeta = Planeta::updateOrCreate(
                    ['nombre' => $planetaData['name']],
                    [
                        'clima'   => $planetaData['climate'] ?? null,
                        'terreno' => $planetaData['terrain'] ?? null,
                    ]
                );
                $personaje->planeta_id = $planeta->planeta_id;
                $personaje->save();
            }
        }

        // Relacionar películas
        if(isset($data['films'])) {
            foreach($data['films'] as $filmUrl) {
                $filmResponse = Http::get($filmUrl);
                if($filmResponse->successful()){
                    $filmData = $filmResponse->json();
                    $pelicula = Pelicula::updateOrCreate(
                        ['titulo' => $filmData['title']],
                        [
                            'director' => $filmData['director'] ?? null,
                            'fecha_estreno' => $filmData['release_date'] ?? null,
                        ]
                    );
                    $personaje->peliculas()->syncWithoutDetaching([$pelicula->pelicula_id]);
                }
            }
        }

        // Relacionar vehículos
        if(isset($data['vehicles'])) {
            foreach($data['vehicles'] as $vehicleUrl) {
                $vehicleResponse = Http::get($vehicleUrl);
                if($vehicleResponse->successful()){
                    $vehicleData = $vehicleResponse->json();
                    $vehiculo = Vehiculo::updateOrCreate(
                        ['nombre' => $vehicleData['name']],
                        [
                            'modelo'      => $vehicleData['model'] ?? null,
                            'fabricante'  => $vehicleData['manufacturer'] ?? null,
                            'costo'       => (is_numeric($vehicleData['cost_in_credits'] ?? null)) ? $vehicleData['cost_in_credits'] : null,
                        ]
                    );
                    $personaje->vehiculos()->syncWithoutDetaching([$vehiculo->vehiculo_id]);
                }
            }
        }

        // Relacionar especies
        if(isset($data['species'])) {
            foreach($data['species'] as $speciesUrl) {
                $speciesResponse = Http::get($speciesUrl);
                if($speciesResponse->successful()){
                    $speciesData = $speciesResponse->json();
                    $especie = Especie::updateOrCreate(
                        ['nombre' => $speciesData['name']],
                        [
                            'clasificacion'   => $speciesData['classification'] ?? null,
                            'designacion'     => $speciesData['designation'] ?? null,
                            'altura_promedio' => (is_numeric($speciesData['average_height'] ?? null)) ? $speciesData['average_height'] : null,
                        ]
                    );
                    $personaje->especies()->syncWithoutDetaching([$especie->especie_id]);
                }
            }
        }

        Cache::put($cacheKey, $personaje, 3600);
        $this->logConsulta($request->user()->usuario_id, "GET /swapi/personaje/{$id}", $data);

        return response()->json(['from_cache' => false, 'data' => $personaje]);
    }

    // Obtener y almacenar un planeta
    public function storePlaneta(Request $request, $id)
    {
        $cacheKey = 'swapi_planeta_' . $id;
        if(Cache::has($cacheKey)) {
            $data = Cache::get($cacheKey);
            return response()->json(['from_cache' => true, 'data' => $data]);
        }

        $response = Http::get($this->baseUrl . "planets/{$id}/");
        if ($response->failed()) {
            return response()->json(['error' => 'No se encontró el planeta'], 404);
        }
        $data = $response->json();

        $planeta = Planeta::updateOrCreate(
            ['nombre' => $data['name']],
            [
                'clima'   => $data['climate'] ?? null,
                'terreno' => $data['terrain'] ?? null,
            ]
        );

        $this->logConsulta($request->user()->usuario_id, "GET /swapi/planeta/{$id}", $data);
        Cache::put($cacheKey, $planeta, 3600);
        return response()->json(['from_cache' => false, 'data' => $planeta]);
    }

    // Obtener y almacenar una película
    public function storePelicula(Request $request, $id)
    {
        $cacheKey = 'swapi_pelicula_' . $id;
        if(Cache::has($cacheKey)) {
            $data = Cache::get($cacheKey);
            return response()->json(['from_cache' => true, 'data' => $data]);
        }

        $response = Http::get($this->baseUrl . "films/{$id}/");
        if ($response->failed()) {
            return response()->json(['error' => 'No se encontró la película'], 404);
        }
        $data = $response->json();

        $pelicula = Pelicula::updateOrCreate(
            ['titulo' => $data['title']],
            [
                'director' => $data['director'] ?? null,
                'fecha_estreno' => $data['release_date'] ?? null,
            ]
        );

        // Relacionar personajes
        if(isset($data['characters'])) {
            foreach($data['characters'] as $characterUrl) {
                $characterResponse = Http::get($characterUrl);
                if($characterResponse->successful()){
                    $characterData = $characterResponse->json();
                    $personaje = Personaje::updateOrCreate(
                        ['nombre' => $characterData['name']],
                        [
                            'altura' => $characterData['height'] ?? null,
                            'peso'   => $characterData['mass'] ?? null,
                        ]
                    );
                    $pelicula->personajes()->syncWithoutDetaching([$personaje->personaje_id]);
                }
            }
        }

        // Relacionar planetas
        if(isset($data['planets'])) {
            foreach($data['planets'] as $planetUrl) {
                $planetResponse = Http::get($planetUrl);
                if($planetResponse->successful()){
                    $planetData = $planetResponse->json();
                    $planeta = Planeta::updateOrCreate(
                        ['nombre' => $planetData['name']],
                        [
                            'clima'   => $planetData['climate'] ?? null,
                            'terreno' => $planetData['terrain'] ?? null,
                        ]
                    );
                    $pelicula->planetas()->syncWithoutDetaching([$planeta->planeta_id]);
                }
            }
        }

        Cache::put($cacheKey, $pelicula, 3600);
        $this->logConsulta($request->user()->usuario_id, "GET /swapi/pelicula/{$id}", $data);
        return response()->json(['from_cache' => false, 'data' => $pelicula]);
    }

    // Historial de consultas del usuario autenticado
    public function historial(Request $request)
    {
        $historial = HistorialConsulta::where('usuario_id', $request->user()->usuario_id)->get();
        return response()->json($historial);
    }
}
