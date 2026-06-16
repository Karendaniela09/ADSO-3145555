# ADR-003: Implementar Liquibase para versionamiento del DDL

**Título:** Usar Liquibase como herramienta oficial de versionamiento y migración de la base de datos

**Contexto**  
El archivo entregado `modelo_postgresql.sql` contiene todo el DDL en un único script grande y estático. No existe control de versiones ni mecanismo para aplicar cambios de forma ordenada y segura.

**Problema**  
Sin un sistema de migraciones es imposible mantener el esquema de forma controlada, reproducible y trazable en entornos de desarrollo, QA y producción.

**Decisión**  
Implementar **Liquibase** con la siguiente estrategia:
- Archivo maestro `changelog-master.xml`.
- Un changelog por dominio funcional (máximo un dominio por archivo).
- Formato XML (como recomienda la documentación oficial y el instrumento de evaluación).
- Carpeta `liquibase/changelogs/` organizada por dominio.

**Justificación técnica**  
- Liquibase es el estándar de facto para PostgreSQL en proyectos profesionales.  
- Permite rollback, etiquetado de versiones, ejecución condicional y orden garantizado.  
- Cumple exactamente con el entregable 4.7 del instrumento de evaluación.  
- Facilita el trabajo colaborativo con las ramas `develop` → `qa` → `main`.

**Consecuencias / Impacto esperado**  
- La base de datos queda completamente versionada y mantenible.  
- Se puede levantar el esquema completo desde cero con un solo comando.  
- Ligero overhead inicial de configuración, pero gran beneficio a largo plazo.