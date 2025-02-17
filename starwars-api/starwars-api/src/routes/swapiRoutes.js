// Importación de módulos necesarios
const express = require('express');
const router = express.Router();
const authMiddleware = require('../middleware/authMiddleware');

// Importa las funciones del controlador de SWAPI
const {
  getAndStorePersonaje,
  getAndStorePlanet,
  getAndStoreFilm,
  getUserHistory
} = require('../controllers/swapiController');

// 📌 Rutas protegidas por el middleware de autenticación (authMiddleware)

// 🔹 Obtener y almacenar un personaje por ID
router.get('/people/:id', authMiddleware, getAndStorePersonaje);

// 🔹 Obtener y almacenar un planeta por ID
router.get('/planets/:id', authMiddleware, getAndStorePlanet);

// 🔹 Obtener y almacenar una película por ID
router.get('/films/:id', authMiddleware, getAndStoreFilm);

// 🔹 Obtener el historial de consultas del usuario
router.get('/history', authMiddleware, getUserHistory);

module.exports = router; // Exporta las rutas para ser utilizadas en `index.js`
