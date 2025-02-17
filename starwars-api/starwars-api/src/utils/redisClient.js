const redis = require('redis');

// Creación del cliente Redis con configuración basada en variables de entorno
const client = redis.createClient({
  socket: {
    host: process.env.REDIS_HOST, // Dirección del servidor Redis
    port: process.env.REDIS_PORT  // Puerto del servidor Redis
  }
});

// Manejo de errores en la conexión
client.on('error', (err) => console.error('Redis Client Error', err));

// Conexión asíncrona a Redis
(async () => {
  try {
    await client.connect();
    console.log('✅ Conectado a Redis');
  } catch (error) {
    console.error('❌ Error al conectar a Redis:', error);
  }
})();

module.exports = client; // Exporta la conexión para su uso en otras partes del proyecto