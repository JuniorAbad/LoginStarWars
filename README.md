Star Wars API - Proyecto Backend

Este proyecto es una API que consume y almacena datos de SWAPI (Star Wars API), permitiendo autenticación segura, historial de consultas y optimización con caché.

🚀 Características

Autenticación con JWT (Registro, Login, Logout).

Consumo de SWAPI (Personajes, películas, planetas, etc.).

Historial de consultas por usuario.

Optimización con Redis (Evita consultas repetitivas a SWAPI).

Dockerización con PostgreSQL y Redis.

📌 Requisitos Previos

Asegúrate de tener instalados los siguientes programas:

Docker y Docker Compose

Node.js (versión 18 o superior)

npm (gestor de paquetes de Node.js)

Instala node-fetch (En la raíz de tu proyecto (donde está tu package.json), ejecutar)
npm install node-fetch

🔧 Configuración y Ejecución

1️⃣ Clonar el Repositorio

  git clone https://github.com/tu-usuario/starwars-api.git
  cd starwars-api

2️⃣ Configurar Variables de Entorno

Crea un archivo `` en la raíz del proyecto con la siguiente configuración:

DB_HOST=postgres
DB_PORT=5432
DB_USER=user
DB_PASSWORD=password
DB_NAME=starwarsdb
REDIS_HOST=redis
REDIS_PORT=6379
JWT_SECRET=tu_secreto_seguro
PORT=3000

3️⃣ Levantar la Aplicación con Docker

Ejecuta el siguiente comando para iniciar los servicios:

  docker-compose up -d

Este comando ejecutará los siguientes contenedores:

app → Backend de la aplicación.

postgres → Base de datos PostgreSQL.

redis → Servidor Redis para caching.

4️⃣ Verificar los Contenedores en Ejecución

  docker ps

5️⃣ Acceder a la API

La API estará disponible en ``.

📌 Endpoints Principales

Método

Ruta

Descripción

POST

/auth/register

Registro de usuario

POST

/auth/login

Inicio de sesión

GET

/swapi/characters

Obtener personajes de Star Wars

GET

/swapi/movies

Obtener películas de Star Wars

6️⃣ Detener los Contenedores

  docker-compose down

🛠 Estructura del Proyecto

📂 starwars-api/
├── 📂 src/
│   ├── 📂 controllers/        # Lógica de negocio
│   │   ├── authController.js
│   │   ├── swapiController.js
│   ├── 📂 middleware/         # Middlewares
│   │   ├── authMiddleware.js
│   ├── 📂 models/             # Modelos de BD
│   │   ├── User.js
│   ├── 📂 routes/             # Definición de rutas
│   │   ├── authRoutes.js
│   │   ├── swapiRoutes.js
│   ├── 📂 utils/              # Utilidades
│   │   ├── db.js
│   │   ├── redisClient.js
├── Dockerfile                 # Imagen Docker de la app
├── docker-compose.yml          # Orquestación de servicios
├── index.js                    # Punto de entrada
├── package.json                # Dependencias
├── README.md                   # Documentación

📝 Notas Finales

Asegúrate de que los puertos 3000 (API), 5432 (PostgreSQL) y 6379 (Redis) estén libres.

Si necesitas reiniciar la base de datos, elimina los volúmenes de Docker con:

docker-compose down -v

¡Listo! 🎉 Ahora tu API de Star Wars está completamente funcional y lista para usarse. 🚀

