// Importación de módulos necesarios
const express = require('express');
const router = express.Router();
const { register, login, logout } = require('../controllers/authController');

// 📌 Rutas para autenticación de usuarios

// 🔹 Registro de usuario
router.post('/register', register);

// 🔹 Inicio de sesión
router.post('/login', login);

// 🔹 Cierre de sesión
router.post('/logout', logout);

module.exports = router; // Exporta las rutas para ser utilizadas en `index.js`