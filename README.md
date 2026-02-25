
## Automatización Backend – Swagger Petstore

 **Descripción General**

Este proyecto contiene la automatización de pruebas del backend de la API pública Swagger Petstore, utilizando el framework Karate DSL con Maven.

La automatización cubre los módulos principales del sistema:

- **STORE**

- **USER**

Las pruebas están organizadas bajo los enfoques:

< Happy Path (escenarios exitosos) >

< Unhappy Path (escenarios negativos y validaciones de error) >

## ¿Qué hace la automatización?

La suite valida el correcto funcionamiento de los endpoints REST del Petstore:

**STORE**

✔ Escenarios Happy

  - Obtener inventario (GET /store/inventory)
  - Crear orden (POST /store/order)
  - Consultar orden por ID (GET /store/order/{id})
  - Eliminar orden (DELETE /store/order/{id})

X Escenarios Unhappy 

- Crear orden con datos inválidos 
- Buscar orden con ID inválido 
- Buscar orden inexistente 
- Eliminar orden inexistente 
- Eliminar orden con ID inválido

**USER**

✔ Escenarios Happy

- Crear usuario (POST /user)
- Crear usuarios con lista (POST /user/createWithList)
- Crear usuarios con array (POST /user/createWithArray)
- Obtener usuario por username (GET /user/{username})
- Actualizar usuario (PUT /user/{username})
- Eliminar usuario (DELETE /user/{username})
- Login (GET /user/login)
- Logout (GET /user/logout)

X Escenarios Unhappy

- Crear usuario con datos inválidos 
- Obtener usuario inexistente 
- Eliminar usuario inexistente 
- Actualizar usuario inválido (BUG API detectado)
- Login con credenciales inválidas (limitación del mock)

**Tecnologías utilizadas** 

- Java
- Maven
- Karate DSL
- JUnit
- Logback

Ejecutar individualmente:

StoreRunner → Ejecuta pruebas del módulo STORE

UsersRunner → Ejecuta pruebas del módulo USER

Ejecutar por tags:

    mvn test -Dkarate.options="--tags @happy"
    mvn test -Dkarate.options="--tags @unhappy"
    mvn test -Dkarate.options="--tags @regression"

Comando para ejecutar: 

User:

    mvn clean test -Dtest=UsersRunner -Dkarate.options="--tags @regression" -Dkarate.env=dev

Store:

    mvn clean test -Dtest=StoreRunner -Dkarate.options="--tags @regression" -Dkarate.env=dev
