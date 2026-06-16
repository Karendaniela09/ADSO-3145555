# ADR-005: Estrategia de despliegue con Docker Compose

**Título:** Contenerizar la base de datos completa con Docker Compose

**Contexto**  
El proyecto debe poder ser levantado de forma rápida, reproducible y consistente en cualquier máquina (computador del aprendiz, del instructor, entorno local, etc.).

**Problema**  
Actualmente solo se cuenta con el script SQL. No existe una forma automática de levantar la base de datos 100% funcional (estructura + datos de prueba) con un solo comando.

**Decisión**  
Crear un archivo `docker-compose.yml` que:
- Levante PostgreSQL 16 en un contenedor.
- Ejecute automáticamente Liquibase con todos los changelogs.
- Cargue los datos de prueba en el orden correcto de dependencias.
- Exponga el puerto 5432 para conectarse fácilmente con pgAdmin, DBeaver o cualquier cliente.
- Incluya volúmenes persistentes para los datos.

**Justificación técnica**  
- Cumple directamente con el entregable 4.6 (Estrategia de despliegue técnico con contenedores).  
- Permite que al ejecutar `docker compose up -d` se tenga **toda la base de datos funcional** lista para usar.  
- Es la forma moderna y profesional de entregar una base de datos en proyectos reales.  
- Facilita la fase desescolarizada y la demostración al instructor.

**Consecuencias / Impacto esperado**  
- Un solo comando levanta la BD completa y lista para trabajar.  
- Entorno idéntico para todos los desarrolladores.  
- Preparación directa para futuros servicios (backend, API, etc.).