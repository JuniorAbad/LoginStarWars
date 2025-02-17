// 📌 Importación de módulos
const jwt = require('jsonwebtoken'); // Librería para manejo de JSON Web Tokens (JWT)
require('dotenv').config(); // Carga variables de entorno desde .env

/**
 * 🔹 Middleware para proteger rutas con autenticación JWT.
 * Verifica que el usuario tenga un token válido antes de acceder a rutas protegidas.
 */
const authMiddleware = (req, res, next) => {
  // 📌 Extrae el token desde los encabezados de la petición
  const authHeader = req.header('Authorization');
  if (!authHeader) return res.status(403).json({ message: 'Acceso denegado' });

  // 📌 Separa "Bearer" del token para validación
  const [bearer, rawToken] = authHeader.split(' ');
  if (bearer !== 'Bearer') {
    return res.status(401).json({ message: 'Token inválido, se esperaba "Bearer <token>"' });
  }

  try {
    // 📌 Verifica la validez del token con la clave secreta
    const decoded = jwt.verify(rawToken, process.env.JWT_SECRET);
    req.user = decoded; // Almacena los datos del usuario en `req.user`
    next(); // Llama al siguiente middleware o controlador
  } catch (error) {
    res.status(401).json({ message: 'Token inválido', token: rawToken });
  }
};

// 📌 Exportación del middleware para su uso en rutas protegidas
module.exports = authMiddleware;
