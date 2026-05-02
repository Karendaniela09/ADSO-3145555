# ADR-004: Definir estrategia de versionamiento del repositorio

**Título:** Estrategia Git Flow simplificada con ramas develop, qa y main

**Contexto**  
El proyecto requiere una estructura clara de ramas para trabajar de forma ordenada durante la fase supervisada y la fase desescolarizada.

**Problema**  
Sin una estrategia definida de versionamiento se generan conflictos, pérdida de trazabilidad y dificultad para revisar cambios antes de pasar a entornos de prueba o producción.

**Decisión**  
Adoptar la siguiente estrategia Git Flow simplificada:
- `main` → Rama estable de producción (solo se mergea desde `qa`).
- `qa` → Rama de pruebas y validación (merge desde `develop`).
- `develop` → Rama de desarrollo activo (donde se trabaja diariamente).
- Feature branches: `feature/HU-XXX-nombre-descriptivo`.
- Hotfix y release branches cuando sea necesario.

**Justificación técnica**  
- Es una de las estrategias más usadas y recomendadas en proyectos reales.  
- Cumple exactamente con el requerimiento explícito del instrumento de evaluación (entregable 4.3).  
- Permite revisión de código (pull requests) antes de pasar a qa y main.

**Consecuencias / Impacto esperado**  
- Orden y trazabilidad total del proyecto.  
- Facilita el trabajo en equipo y la integración continua.  
- Preparación directa para futuros pipelines de CI/CD.