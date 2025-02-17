const { Pool } = require('pg');

// Configuración de la conexión a PostgreSQL utilizando variables de entorno
const pool = new Pool({
  user: process.env.DB_USER,       // Usuario de la base de datos
  host: process.env.DB_HOST,       // Dirección del servidor de la base de datos
  database: process.env.DB_NAME,   // Nombre de la base de datos
  password: process.env.DB_PASSWORD, // Contraseña del usuario
  port: process.env.DB_PORT        // Puerto de conexión (por defecto 5432)
});

module.exports = pool; // Exporta la conexión para ser utilizada en otras partes del proyecto