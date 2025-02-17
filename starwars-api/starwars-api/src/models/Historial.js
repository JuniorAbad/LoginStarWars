const pool = require('../utils/db');
/**
 * Registra una consulta en la tabla HistorialConsultas.
 * @param {number} usuario_id - ID del usuario autenticado.
 * @param {string} endpoint - Ruta solicitada (e.g. "/api/people/1").
 * @param {object} params - Objeto con detalles adicionales (se guarda como JSON).
 */
const logQuery = async (usuario_id, endpoint, params) => {
  await pool.query(
    `INSERT INTO HistorialConsultas (usuario_id, endpoint, params)
     VALUES ($1, $2, $3)`,
    [usuario_id, endpoint, JSON.stringify(params)]
  );
};

/**
 * Obtiene todo el historial de consultas de un usuario, ordenado por fecha DESC.
 * @param {number} usuario_id - ID del usuario autenticado.
 * @returns {Promise<Array>} - Arreglo de objetos con la info del historial.
 */
const getHistoryByUser = async (usuario_id) => {
  const result = await pool.query(
    `SELECT * FROM HistorialConsultas
     WHERE usuario_id = $1
     ORDER BY fecha DESC`,
    [usuario_id]
  );
  return result.rows;
};

module.exports = { logQuery, getHistoryByUser };