// index.js

// Carga las variables de entorno desde el archivo .env
require('dotenv').config();

// Importación de módulos
const express = require('express');
const cors = require('cors');
const redis = require("redis");

// Importación de rutas
const authRoutes = require('./src/routes/authRoutes');  // Rutas de autenticación
const swapiRoutes = require('./src/routes/swapiRoutes');  // Rutas para consumir la API de Star Wars (SWAPI)
const client = redis.createClient({
  host: "127.0.0.1",
  port: 6379
});
client.on("error", (err) => {
  console.error("Redis Client Error", err);
});

client.connect();
// Creación de la aplicación Express
const app = express();

// Habilita CORS para permitir solicitudes desde otros dominios
app.use(cors());

// Habilita el uso de JSON en las solicitudes
app.use(express.json());

// Definición de rutas
app.use('/api', authRoutes);  // Rutas relacionadas con autenticación (login, registro)
app.use('/api', swapiRoutes); // Rutas para consultar información de SWAPI

// Definición del puerto
const PORT = process.env.PORT || 3000;

// Inicia el servidor
app.listen(PORT, () => {
  console.log(`Servidor corriendo en http://localhost:${PORT}`);
});

/*
📌 Notas:
- Este archivo es el punto de entrada de la aplicación.
- Utiliza Express para manejar las solicitudes HTTP.
- Se configuran rutas para autenticación y consumo de la API de Star Wars.
- Se leen las variables de entorno desde un archivo .env.
- Si el puerto no está definido en las variables de entorno, se usa el 3000 por defecto.
*/
