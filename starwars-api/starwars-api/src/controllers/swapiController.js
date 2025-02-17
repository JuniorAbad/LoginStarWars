// src/controllers/swapiController.js

const fetch = require('node-fetch'); // Importar node-fetch correctamente
const pool = require('../utils/db');
const redisClient = require('../utils/redisClient');
const { logQuery, getHistoryByUser } = require('../models/Historial');
const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');

// 1) OBTENER Y ALMACENAR UNA PERSONA
const getAndStorePersonaje = async (req, res) => {
  try {
    const { id } = req.params;
    const usuario_id = req.user.id;
    const cacheKey = `personaje:${id}`;

    // Revisar caché en Redis
    const cachedData = await redisClient.get(cacheKey);
    if (cachedData) {
      await logQuery(usuario_id, `/api/people/${id}`, { source: 'cache' });
      return res.json({ source: 'cache', data: JSON.parse(cachedData) });
    }

    // Consumir SWAPI usando fetch
    const response = await fetch(`https://swapi.dev/api/people/${id}/`);
    if (!response.ok) {
      return res.status(404).json({ message: 'Personaje no encontrado en SWAPI' });
    }
    const personajeData = await response.json();

    // Guardar planeta de origen
    const homeResponse = await fetch(personajeData.homeworld);
    const homeData = await homeResponse.json();
    const planetaResult = await pool.query(
      `INSERT INTO Planetas (nombre, clima, terreno)
       VALUES ($1, $2, $3)
       ON CONFLICT (nombre) DO UPDATE SET clima=EXCLUDED.clima, terreno=EXCLUDED.terreno
       RETURNING planeta_id`,
      [homeData.name, homeData.climate, homeData.terrain]
    );
    const planeta_id = planetaResult.rows[0].planeta_id;

    const parseNumeric = (value) => {
      return isNaN(value) || value === "unknown" ? null : Number(value);
    };

    // Guardar personaje
    const personajeResult = await pool.query(
      `INSERT INTO Personajes (nombre, altura, peso, planeta_id)
       VALUES ($1, $2, $3, $4)
       RETURNING *`,
      [personajeData.name, parseNumeric(personajeData.height), parseNumeric(personajeData.mass), planeta_id]
    );
    const personaje = personajeResult.rows[0];

    // Relacionar películas
    for (let filmUrl of personajeData.films) {
      const filmRes = await fetch(filmUrl);
      if (filmRes.ok) {
        const filmData = await filmRes.json();
        const filmResult = await pool.query(
          `INSERT INTO Peliculas (titulo, director, fecha_estreno)
           VALUES ($1, $2, $3)
           ON CONFLICT (titulo) DO UPDATE SET director=EXCLUDED.director, fecha_estreno=EXCLUDED.fecha_estreno
           RETURNING pelicula_id`,
          [filmData.title, filmData.director, filmData.release_date]
        );
        await pool.query(
          `INSERT INTO Personaje_Pelicula (personaje_id, pelicula_id)
           VALUES ($1, $2)
           ON CONFLICT DO NOTHING`,
          [personaje.personaje_id, filmResult.rows[0].pelicula_id]
        );
      }
    }

    // Relacionar vehículos
    for (let vehicleUrl of personajeData.vehicles) {
      const vehicleRes = await fetch(vehicleUrl);
      if (vehicleRes.ok) {
        const vehicleData = await vehicleRes.json();
        const vehicleResult = await pool.query(
          `INSERT INTO Vehiculos (nombre, modelo, fabricante, costo)
           VALUES ($1, $2, $3, $4)
           ON CONFLICT (nombre) DO UPDATE 
           SET modelo=EXCLUDED.modelo, fabricante=EXCLUDED.fabricante, costo=EXCLUDED.costo
           RETURNING vehiculo_id`,
          [vehicleData.name, vehicleData.model, vehicleData.manufacturer, parseNumeric(vehicleData.cost_in_credits)]
        );
        await pool.query(
          `INSERT INTO Personaje_Vehiculo (personaje_id, vehiculo_id)
           VALUES ($1, $2)
           ON CONFLICT DO NOTHING`,
          [personaje.personaje_id, vehicleResult.rows[0].vehiculo_id]
        );
      }
    }

    // Relacionar especies
    for (let speciesUrl of personajeData.species) {
      const speciesRes = await fetch(speciesUrl);
      if (speciesRes.ok) {
        const speciesData = await speciesRes.json();
        const speciesResult = await pool.query(
          `INSERT INTO Especies (nombre, clasificacion, designacion, altura_promedio)
           VALUES ($1, $2, $3, $4)
           ON CONFLICT (nombre) DO UPDATE SET clasificacion=EXCLUDED.clasificacion, designacion=EXCLUDED.designacion, altura_promedio=EXCLUDED.altura_promedio
           RETURNING especie_id`,
          [speciesData.name, speciesData.classification, speciesData.designation, speciesData.average_height]
        );
        await pool.query(
          `INSERT INTO Personaje_Especie (personaje_id, especie_id)
           VALUES ($1, $2)
           ON CONFLICT DO NOTHING`,
          [personaje.personaje_id, speciesResult.rows[0].especie_id]
        );
      }
    }

    // Guardar en caché
    await redisClient.setEx(cacheKey, 3600, JSON.stringify(personaje));

    // Registrar historial
    await logQuery(usuario_id, `/api/people/${id}`, { source: 'api' });

    // Responder
    return res.json({ source: 'api', data: personaje });
  } catch (error) {
    console.error('Error en getAndStorePersonaje:', error);
    return res.status(500).json({ error: error.message });
  }
};

// 2) OBTENER Y ALMACENAR UN PLANETA
const getAndStorePlanet = async (req, res) => {
  try {
    const { id } = req.params;
    const usuario_id = req.user.id;
    const cacheKey = `planeta:${id}`;

    // Revisar caché en Redis
    const cachedData = await redisClient.get(cacheKey);
    if (cachedData) {
      await logQuery(usuario_id, `/api/planets/${id}`, { source: 'cache' });
      return res.json({ source: 'cache', data: JSON.parse(cachedData) });
    }

    // Consumir SWAPI usando fetch
    const response = await fetch(`https://swapi.dev/api/planets/${id}/`);
    if (!response.ok) {
      return res.status(404).json({ message: 'Planeta no encontrado en SWAPI' });
    }
    const planetaData = await response.json();

    // Guardar planeta en la base de datos
    const planetaResult = await pool.query(
      `INSERT INTO Planetas (nombre, clima, terreno)
       VALUES ($1, $2, $3)
       ON CONFLICT (nombre) DO UPDATE SET clima=EXCLUDED.clima, terreno=EXCLUDED.terreno
       RETURNING *`,
      [planetaData.name, planetaData.climate, planetaData.terrain]
    );
    const planeta = planetaResult.rows[0];

    // Guardar en caché
    await redisClient.setEx(cacheKey, 3600, JSON.stringify(planeta));

    // Registrar historial
    await logQuery(usuario_id, `/api/planets/${id}`, { source: 'api' });

    // Responder
    return res.json({ source: 'api', data: planeta });
  } catch (error) {
    console.error('Error en getAndStorePlanet:', error);
    return res.status(500).json({ error: error.message });
  }
};

// 3) OBTENER Y ALMACENAR UNA PELÍCULA
const getAndStoreFilm = async (req, res) => {
  try {
    const { id } = req.params;
    const usuario_id = req.user.id;
    const cacheKey = `pelicula:${id}`;

    // Revisar caché en Redis
    const cachedData = await redisClient.get(cacheKey);
    if (cachedData) {
      await logQuery(usuario_id, `/api/films/${id}`, { source: 'cache' });
      return res.json({ source: 'cache', data: JSON.parse(cachedData) });
    }

    // Consumir SWAPI usando fetch
    const response = await fetch(`https://swapi.dev/api/films/${id}/`);
    if (!response.ok) {
      return res.status(404).json({ message: 'Película no encontrada en SWAPI' });
    }
    const peliculaData = await response.json();

    // Guardar película en la base de datos
    const peliculaResult = await pool.query(
      `INSERT INTO Peliculas (titulo, director, fecha_estreno)
       VALUES ($1, $2, $3)
       ON CONFLICT (titulo) DO UPDATE SET director=EXCLUDED.director, fecha_estreno=EXCLUDED.fecha_estreno
       RETURNING *`,
      [peliculaData.title, peliculaData.director, peliculaData.release_date]
    );
    const pelicula = peliculaResult.rows[0];

    // Guardar en caché
    await redisClient.setEx(cacheKey, 3600, JSON.stringify(pelicula));

    // Registrar historial
    await logQuery(usuario_id, `/api/films/${id}`, { source: 'api' });

    // Responder
    return res.json({ source: 'api', data: pelicula });
  } catch (error) {
    console.error('Error en getAndStoreFilm:', error);
    return res.status(500).json({ error: error.message });
  }
};

// 4) OBTENER HISTORIAL DE USUARIO
const getUserHistory = async (req, res) => {
  try {
    const usuario_id = req.user.id;
    const historial = await getHistoryByUser(usuario_id);
    return res.json(historial);
  } catch (error) {
    console.error('Error en getUserHistory:', error);
    return res.status(500).json({ error: error.message });
  }
};

// Exportar las funciones
module.exports = {
  getAndStorePersonaje,
  getAndStorePlanet,
  getAndStoreFilm,
  getUserHistory
};

// Definir rutas protegidas con authMiddleware
router.get('/people/:id', authMiddleware, getAndStorePersonaje);
router.get('/planets/:id', authMiddleware, getAndStorePlanet);
router.get('/films/:id', authMiddleware, getAndStoreFilm);
router.get('/history', authMiddleware, getUserHistory);