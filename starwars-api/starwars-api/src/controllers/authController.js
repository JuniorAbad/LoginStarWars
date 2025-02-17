// 📌 Importación de módulos
const jwt = require('jsonwebtoken'); // Manejo de autenticación con JSON Web Tokens (JWT)
const bcrypt = require('bcryptjs'); // Encriptación de contraseñas
const { createUser, findUserByUsername } = require('../models/User'); // Funciones del modelo de usuario

/**
 * 🔹 Registro de usuario.
 * Crea un nuevo usuario en la base de datos si el nombre de usuario no existe.
 */
const register = async (req, res) => {
  try {
    const { username, password, email } = req.body;

    // 📌 Verifica si el usuario ya existe
    const userExists = await findUserByUsername(username);
    if (userExists) {
      return res.status(400).json({ message: 'Usuario ya existe' });
    }

    // 📌 Crea el usuario en la base de datos
    const user = await createUser(username, password, email);
    res.status(201).json({ message: 'Usuario registrado', user });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

/**
 * 🔹 Inicio de sesión de usuario.
 * Verifica las credenciales y devuelve un token JWT si son correctas.
 */
const login = async (req, res) => {
  try {
    const { username, password } = req.body;

    // 📌 Busca al usuario en la base de datos
    const user = await findUserByUsername(username);
    if (!user || !(await bcrypt.compare(password, user.contraseña_hash))) {
      return res.status(401).json({ message: 'Credenciales inválidas' });
    }

    // 📌 Genera un token JWT con los datos del usuario
    const token = jwt.sign(
      { id: user.usuario_id, username: user.nombre_usuario },
      process.env.JWT_SECRET,
      { expiresIn: process.env.JWT_EXPIRES_IN }
    );

    res.json({ message: 'Inicio de sesión exitoso', token });
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

/**
 * 🔹 Cierre de sesión (Placeholder).
 * Actualmente, solo envía una respuesta de éxito.
 */
const logout = (req, res) => {
  res.json({ message: 'Cierre de sesión exitoso' });
};

// 📌 Exportación de funciones para ser usadas en las rutas de autenticación
module.exports = { register, login, logout };
