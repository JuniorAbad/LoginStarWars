// 📌 Importación de módulos necesarios
const pool = require('../utils/db'); // Conexión a PostgreSQL
const bcrypt = require('bcryptjs'); // Librería para encriptar contraseñas

/**
 * 🔹 Crea un nuevo usuario en la base de datos.
 * @param {string} username - Nombre de usuario
 * @param {string} password - Contraseña en texto plano
 * @param {string} email - Correo electrónico del usuario
 * @returns {object} - Usuario creado en la base de datos
 */
const createUser = async (username, password, email) => {
  // Encripta la contraseña antes de almacenarla
  const hashedPassword = await bcrypt.hash(password, 10);

  // Inserta el usuario en la base de datos y devuelve el registro creado
  const result = await pool.query(
    `INSERT INTO Usuarios (nombre_usuario, contraseña_hash, email)
     VALUES ($1, $2, $3) RETURNING *`,
    [username, hashedPassword, email]
  );
  return result.rows[0]; // Retorna el usuario creado
};

/**
 * 🔹 Busca un usuario por su nombre de usuario.
 * @param {string} username - Nombre de usuario a buscar
 * @returns {object|null} - Usuario encontrado o null si no existe
 */
const findUserByUsername = async (username) => {
  const result = await pool.query(
    `SELECT * FROM Usuarios WHERE nombre_usuario = $1`,
    [username]
  );
  return result.rows[0]; // Retorna el usuario encontrado o null si no existe
};

// 📌 Exportación de funciones para su uso en otros módulos
module.exports = { createUser, findUserByUsername };
