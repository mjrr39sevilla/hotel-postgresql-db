# 🏠 Sistema de Gestión de Alojamiento

Sistema de gestión de alojamiento desarrollado mediante **PostgreSQL y SQL**, diseñado para administrar anfitriones, huéspedes, habitaciones, reservas, pagos, reseñas y servicios asociados.

El proyecto implementa un **modelo relacional** con claves primarias, claves foráneas y diferentes restricciones de integridad, además de consultas SQL orientadas tanto a la gestión como al análisis de los datos.


## 📋 Descripción del proyecto

La aplicación permite gestionar la información relacionada con una plataforma de alojamiento:

* 👤 Anfitriones
* 🧳 Huéspedes
* 🏠 Habitaciones
* 📅 Reservas
* 💳 Pagos
* ⭐ Reseñas
* 🛎️ Servicios
* 🔗 Relación entre habitaciones y servicios

La base de datos está formada por **8 tablas** y utiliza relaciones entre las diferentes entidades para mantener la información organizada y evitar inconsistencias.


## 🗂️ Modelo de datos

Las principales tablas del sistema son:

| Tabla                 | Descripción                                       |
| --------------------- | ------------------------------------------------- |
| `anfitriones`         | Información de los propietarios o anfitriones     |
| `huespedes`           | Información de las personas que realizan reservas |
| `habitaciones`        | Alojamientos disponibles                          |
| `reservas`            | Reservas realizadas por los huéspedes             |
| `pagos`               | Pagos asociados a las reservas                    |
| `resenas`             | Valoraciones y comentarios sobre las habitaciones |
| `servicios`           | Servicios disponibles                             |
| `habitacion_servicio` | Tabla intermedia entre habitaciones y servicios   |

### 🔗 Relaciones principales

**Reservas ↔ Pagos**

Relación **1:1**, implementada mediante `id_reserva` como clave foránea y con restricción `UNIQUE` en la tabla `pagos`. Esto evita que una misma reserva tenga más de un pago.

**Habitaciones ↔ Servicios**

Relación **N:M (muchos a muchos)** implementada mediante la tabla intermedia `habitacion_servicio`.

Una habitación puede disponer de varios servicios y un mismo servicio puede estar asociado a diferentes habitaciones.


## 🛠️ Tecnologías utilizadas

* **PostgreSQL**
* **SQL**
* Modelo relacional
* Claves primarias (**PK**)
* Claves foráneas (**FK**)
* `NOT NULL`
* `UNIQUE`
* `CHECK`
* `ON DELETE CASCADE`
* `JOIN`
* `LEFT JOIN`
* `GROUP BY`
* `HAVING`
* Subconsultas


## 🔎 Consultas SQL

El proyecto incluye **100 consultas SQL**, organizadas progresivamente desde consultas básicas hasta consultas de análisis más avanzadas.

### Consultas básicas

* Mostrar registros de las diferentes tablas.
* Seleccionar columnas concretas.
* Filtrar habitaciones por tipo.
* Buscar reservas según su estado.
* Filtrar por precio.
* Buscar información mediante `LIKE`.

### Ordenamiento y filtros

Se utilizan:

* `ORDER BY`
* `BETWEEN`
* `IN`
* `LIKE`

Por ejemplo, se incluyen consultas para buscar habitaciones por ciudad, ordenar alojamientos por precio y filtrar habitaciones dentro de determinados rangos.

### 🔗 JOIN

Las consultas relacionan información de diferentes tablas para obtener datos como:

* Habitación + anfitrión
* Reserva + huésped
* Reserva + habitación
* Pago + huésped
* Habitación + servicios
* Habitación + reseñas

### 📊 Agregaciones

Se utilizan funciones como:

```sql
COUNT()
AVG()
MAX()
MIN()
SUM()
```

para obtener estadísticas sobre habitaciones, reservas, huéspedes, anfitriones, servicios e ingresos.

### 📈 GROUP BY y HAVING

También se realizan consultas para analizar:

* Habitaciones por tipo.
* Habitaciones por anfitrión.
* Reservas por huésped.
* Reservas por habitación.
* Servicios por habitación.
* Anfitriones con más de una habitación.

### 🧠 Subconsultas

El proyecto incorpora subconsultas para realizar comparaciones y obtener información calculada, como habitaciones cuyo precio supera el precio medio o habitaciones con el mayor número de reservas.

### ✏️ UPDATE y DELETE

También se incluyen operaciones para modificar y eliminar información:

* Actualizar teléfonos.
* Modificar estados de reservas.
* Cambiar precios.
* Actualizar pagos.
* Eliminar servicios asociados.
* Eliminar reservas.


## 🧩 Integridad de los datos

El modelo utiliza diferentes mecanismos para garantizar la consistencia de la información:

* **PK** → identifica de forma única cada registro.
* **FK** → establece relaciones entre tablas.
* **NOT NULL** → evita valores vacíos donde no están permitidos.
* **UNIQUE** → evita duplicados en campos determinados.
* **CHECK** → controla valores permitidos.
* **ON DELETE CASCADE** → permite gestionar eliminaciones relacionadas.


## 📁 Estructura recomendada del repositorio

```text
sistema-gestion-alojamiento/
│
├── README.md
│
├── sql/
│   ├── 01_creacion_tablas.sql
│   ├── 02_insercion_datos.sql
│   └── 03_consultas.sql
│
├── docs/
│   └── Documentacion_Sistema_Alojamiento_SQL.pdf
│
└── DER/
    └── modelo-relacional.png
```

> Puedes adaptar los nombres de las carpetas y archivos a los que tengas realmente en tu repositorio.


## ▶️ Cómo ejecutar el proyecto

### 1. Crear una base de datos PostgreSQL

Crear una nueva base de datos desde PostgreSQL, pgAdmin o la herramienta que utilices.

### 2. Crear las tablas

Ejecutar el script de creación de tablas.

### 3. Insertar los datos

Ejecutar el script con los datos de ejemplo.

### 4. Ejecutar las consultas

Una vez creadas las tablas y cargados los datos, ejecutar el archivo de consultas SQL.

Las consultas del proyecto están diseñadas para ejecutarse después de crear las tablas y cargar los datos de ejemplo.


## 📚 Contenido del proyecto

El repositorio incluye:

* Modelo relacional de la base de datos.
* Creación de tablas.
* Claves primarias y foráneas.
* Restricciones de integridad.
* Datos de ejemplo.
* 100 consultas SQL.
* Consultas con `JOIN` y `LEFT JOIN`.
* Funciones de agregación.
* `GROUP BY` y `HAVING`.
* Subconsultas.
* Operaciones `UPDATE` y `DELETE`.
* Análisis de las relaciones entre entidades.


## 🎯 Objetivos

El objetivo principal del proyecto es diseñar e implementar una base de datos relacional para una plataforma de alojamiento y demostrar el uso de SQL para:

1. Crear y estructurar una base de datos relacional.
2. Mantener la integridad de los datos.
3. Relacionar información entre diferentes tablas.
4. Realizar consultas de búsqueda y filtrado.
5. Obtener estadísticas mediante funciones de agregación.
6. Analizar los datos mediante consultas avanzadas.
7. Modificar y eliminar información de forma controlada.


## 👩‍💻 Autora

**María José Rodríguez Ramos**

Proyecto académico — Sistema de Gestión de Alojamiento


## 📄 Documentación

Para consultar el desarrollo completo del proyecto y las respuestas a las preguntas de análisis, consulta la documentación incluida en el repositorio.

> **Nota:** El documento de referencia conserva la numeración original de las consultas del proyecto, del 1 al 100.
