# Prompt: Generador de Landing Page - Planificación Semestral SENA v1.0

## Descripción General

Este prompt genera un **landing page gamificado** para la planificación semestral de una ficha de formación SENA. La página muestra una **ruta de aprendizaje por competencias** con roadmap, sistema de badges por logro de competencias, progreso persistente y filtros dinámicos.

---

## Diferencias con Versión Universitaria

- ✅ Metodología por Competencias SENA (no cortes académicos)
- ✅ Resultados de Aprendizaje (RAP) como unidades de evaluación
- ✅ Evidencias de aprendizaje (Conocimiento, Desempeño, Producto)
- ✅ Badges por competencias alcanzadas
- ✅ Sesiones por trimestre (no semestres)
- ✅ Evaluación permanente (no parciales)
- ✅ Estructura de horas presenciales y virtuales

---

## Fuentes de Datos (en orden de prioridad)

### 1. Diseño Curricular de la Ficha
```
[ficha]/00-documentos/diseno-curricular.pdf
```
**o**
```
[ficha]/00-documentos/programa-formacion.xlsx
```

Extraer:
- `.competencias` → Competencias específicas de la ficha
- `.rap` → Resultados de Aprendizaje por competencia
- `.duracion` → Horas totales y distribución por etapa
- `.criterios_evaluacion` → Criterios de evaluación por RAP

### 2. Planeación Pedagógica (Alternativa)
```
[ficha]/01-trimestre/planeacion-didactica.xlsx
```

Buscar hojas con:
- **Identificación**: Centro, programa, ficha, jornada
- **Planeación**: Competencias, RAP, actividades, evidencias
- **Distribución horaria**: Horas presenciales, virtuales, autónomas

### 3. Patrones de búsqueda Glob
```bash
# Buscar Diseño Curricular
**/material-[nombre-ficha]/**/diseno-curricular.pdf

# Buscar Planeación
**/material-[nombre-ficha]/**/planeacion-*.xlsx
```

---

## Metodología SENA por Competencias

### Estructura de Competencias

**Indicadores de detección:**
- Palabras clave: "Competencia", "RAP", "Evidencia", "Criterio de Evaluación", "Trimestre"
- Evaluación por Resultados de Aprendizaje
- Evidencias: Conocimiento, Desempeño, Producto
- Sin parciales tradicionales (evaluación permanente)

**Programas típicos:**
- Análisis y Desarrollo de Software (ADSO)
- Gestión de Redes de Datos
- Desarrollo de Operaciones Logísticas
- Diseño e Integración de Multimedia

**Estructura base:**
```javascript
{
    competencia: {
        codigo: "220501046",
        nombre: "Construir el sistema de información que cumpla con los requisitos de la solución informática",
        duracion: 680, // horas
        rap: [
            {
                codigo: "RAP-001",
                descripcion: "Identificar los requisitos necesarios para construir el sistema de información",
                evidencias: {
                    conocimiento: ["Quiz requisitos", "Evaluación casos de uso"],
                    desempeno: ["Simulación levantamiento requisitos"],
                    producto: ["Documento de requisitos SRS"]
                }
            }
        ]
    }
}
```

---

## Estructura de Archivos de Salida

```
[ficha]/00-planning/
├── index.html          # Landing page principal
├── css/
│   └── styles.css      # Estilos (colores SENA: naranja #FF5200)
└── js/
    └── app.js          # Datos de la ficha + lógica de gamificación
```

---

## Especificación Detallada: app.js

### Estructura COURSE_DATA (Adaptación SENA)

```javascript
const COURSE_DATA = {
    // === METADATA ===
    name: "Nombre del Programa de Formación",
    codigo: "228106", // Código del programa
    ficha: "2654321",
    centro: "Centro de la Tecnología del Diseño y la Productividad Empresarial",
    totalWeeks: 18, // Por trimestre (aprox.)
    methodology: "competencias", // Siempre "competencias" para SENA

    // === COMPETENCIAS Y RAP ===
    competencias: [
        {
            id: 1,
            codigo: "220501046",
            name: "Construir el sistema de información",
            weeks: [1, 2, 3, 4, 5, 6, 7, 8],
            duracion: 680, // horas
            fase: "Análisis",
            rap: [
                {
                    id: "RAP-001",
                    descripcion: "Identificar requisitos necesarios",
                    weeks: [1, 2, 3]
                },
                {
                    id: "RAP-002", 
                    descripcion: "Construir bases de datos",
                    weeks: [4, 5, 6]
                },
                {
                    id: "RAP-003",
                    descripcion: "Codificar módulos del sistema",
                    weeks: [7, 8]
                }
            ]
        },
        {
            id: 2,
            codigo: "220501022",
            name: "Aplicar buenas prácticas de calidad",
            weeks: [9, 10, 11, 12, 13, 14, 15, 16],
            duracion: 560,
            fase: "Desarrollo",
            rap: [
                // ...
            ]
        }
    ],

    // === SEMANAS ===
    weeks: [
        {
            num: 1,
            title: "Introducción a Requisitos",
            topic: "Levantamiento de información",
            competencia: 1, // ID de la competencia
            rap: "RAP-001",
            type: "normal", // normal | evaluacion | cierre
            content: {
                presencial: "Clase magistral sobre técnicas de levantamiento",
                virtual: "Video tutorial: Entrevistas efectivas",
                autonomo: "Lectura: IEEE 830 - SRS"
            },
            evidencias: {
                conocimiento: "Quiz sobre requisitos funcionales y no funcionales",
                desempeno: null,
                producto: null
            },
            tags: ["UML", "Requisitos", "IEEE 830"]
        },
        {
            num: 5,
            title: "Evaluación RAP-001",
            topic: "Entrega documento SRS",
            competencia: 1,
            rap: "RAP-001",
            type: "evaluacion",
            content: {
                presencial: "Sustentación de documento de requisitos",
                virtual: "N/A",
                autonomo: "Preparación de presentación"
            },
            evidencias: {
                conocimiento: "Evaluación escrita de conceptos",
                desempeno: "Sustentación ante instructor",
                producto: "Documento SRS completo"
            },
            tags: ["Evaluación", "SRS", "Sustentación"]
        }
    ],

    // === BADGES POR COMPETENCIAS (mínimo 6) ===
    badges: [
        {
            id: "starter",
            icon: "🚀",
            name: "Iniciador",
            desc: "Primera semana completada",
            requirement: 1,
            type: "general"
        },
        {
            id: "analyst",
            icon: "🔍",
            name: "Analista",
            desc: "RAP-001 completado",
            requirement: 3,
            competencia: 1,
            type: "rap"
        },
        {
            id: "db-builder",
            icon: "🗄️",
            name: "Constructor BD",
            desc: "RAP-002 completado",
            requirement: 6,
            competencia: 1,
            type: "rap"
        },
        {
            id: "developer",
            icon: "💻",
            name: "Desarrollador",
            desc: "RAP-003 completado",
            requirement: 8,
            competencia: 1,
            type: "rap"
        },
        {
            id: "quality-master",
            icon: "✅",
            name: "Quality Master",
            desc: "Competencia 2 dominada",
            requirement: 16,
            competencia: 2,
            type: "competencia"
        },
        {
            id: "complete",
            icon: "🎓",
            name: "Técnico Completo",
            desc: "Todas las competencias alcanzadas",
            requirement: 18,
            type: "general"
        }
    ]
};
```

### Tipos de Semana

| type | Descripción | Estilo Visual |
|------|-------------|---------------|
| `normal` | Semana regular de formación | Borde gris |
| `evaluacion` | Semana de evaluación de RAP | Borde naranja SENA, icono estrella |
| `cierre` | Semana final/retroalimentación | Borde dorado |

### Tipos de Evidencia (SENA)

| Evidencia | Descripción | Icono sugerido |
|-----------|-------------|----------------|
| `conocimiento` | Quiz, evaluación escrita, oral | 📝 |
| `desempeno` | Simulación, observación, sustentación | 🎭 |
| `producto` | Entregable tangible (documento, software) | 📦 |

---

## Badges Temáticos por Competencias (OBLIGATORIO)

Los badges DEBEN reflejar el logro de RAP y competencias, NO semanas genéricas. Mínimo 6 badges.

### Ejemplo: ADSO (Análisis y Desarrollo de Software)
```javascript
badges: [
    { 
        id: "starter", 
        icon: "🚀", 
        name: "Iniciador ADSO", 
        desc: "Primer paso en formación", 
        requirement: 1,
        type: "general"
    },
    { 
        id: "analyst", 
        icon: "🔍", 
        name: "Analista de Requisitos", 
        desc: "RAP Requisitos completado", 
        requirement: 3,
        competencia: 1,
        rap: "RAP-001",
        type: "rap"
    },
    { 
        id: "db-architect", 
        icon: "🗄️", 
        name: "Arquitecto de BD", 
        desc: "RAP Bases de Datos completado", 
        requirement: 6,
        competencia: 1,
        rap: "RAP-002",
        type: "rap"
    },
    { 
        id: "full-stack", 
        icon: "💻", 
        name: "Full Stack Junior", 
        desc: "Competencia desarrollo alcanzada", 
        requirement: 8,
        competencia: 1,
        type: "competencia"
    },
    { 
        id: "quality-expert", 
        icon: "✅", 
        name: "Experto en Calidad", 
        desc: "Competencia calidad alcanzada", 
        requirement: 16,
        competencia: 2,
        type: "competencia"
    },
    { 
        id: "tecnologo", 
        icon: "🎓", 
        name: "Tecnólogo ADSO", 
        desc: "Todas las competencias alcanzadas", 
        requirement: 18,
        type: "general"
    }
]
```

### Ejemplo: Gestión de Redes de Datos
```javascript
badges: [
    { 
        id: "starter", 
        icon: "🚀", 
        name: "Iniciador Redes", 
        desc: "Primera semana", 
        requirement: 1 
    },
    { 
        id: "networker", 
        icon: "🌐", 
        name: "Networker", 
        desc: "RAP Topologías completado", 
        requirement: 3,
        competencia: 1,
        rap: "RAP-001"
    },
    { 
        id: "router-config", 
        icon: "🔧", 
        name: "Configurador", 
        desc: "RAP Routing completado", 
        requirement: 6,
        competencia: 1,
        rap: "RAP-002"
    },
    { 
        id: "security-pro", 
        icon: "🔐", 
        name: "Security Pro", 
        desc: "Competencia seguridad alcanzada", 
        requirement: 10,
        competencia: 2
    },
    { 
        id: "cloud-expert", 
        icon: "☁️", 
        name: "Cloud Expert", 
        desc: "Competencia cloud alcanzada", 
        requirement: 15,
        competencia: 3
    },
    { 
        id: "network-admin", 
        icon: "🎓", 
        name: "Administrador de Redes", 
        desc: "Todas las competencias alcanzadas", 
        requirement: 18 
    }
]
```

---

## Sección de Tecnologías por Programa

### ADSO (Análisis y Desarrollo de Software)
```html
<div class="tech-grid">
    <div class="tech-card"><span>🐍</span><h4>Python</h4><p>Backend, scripting</p></div>
    <div class="tech-card"><span>☕</span><h4>Java</h4><p>POO, Spring Boot</p></div>
    <div class="tech-card"><span>⚛️</span><h4>React</h4><p>Frontend moderno</p></div>
    <div class="tech-card"><span>🗄️</span><h4>PostgreSQL</h4><p>Base de datos</p></div>
    <div class="tech-card"><span>🐳</span><h4>Docker</h4><p>Contenedores</p></div>
    <div class="tech-card"><span>☁️</span><h4>AWS</h4><p>Cloud computing</p></div>
</div>
```

### Gestión de Redes de Datos
```html
<div class="tech-grid">
    <div class="tech-card"><span>🌐</span><h4>Cisco Packet Tracer</h4><p>Simulación redes</p></div>
    <div class="tech-card"><span>🔧</span><h4>IOS Cisco</h4><p>Configuración routers</p></div>
    <div class="tech-card"><span>🐧</span><h4>Linux Server</h4><p>Administración</p></div>
    <div class="tech-card"><span>🔥</span><h4>Firewalls</h4><p>Seguridad perimetral</p></div>
    <div class="tech-card"><span>📡</span><h4>Wireshark</h4><p>Análisis de tráfico</p></div>
    <div class="tech-card"><span>☁️</span><h4>Cloud Networking</h4><p>AWS, Azure</p></div>
</div>
```

---

## Sección de Evaluación por Competencias

### Para Metodología SENA (Competencias y RAP)
```html
<div class="eval-grid">
    <div class="eval-card eval-card--competencia1">
        <div class="eval-card__header">
            <span class="eval-card__badge">Competencia 1</span>
            <span class="eval-card__codigo">220501046</span>
        </div>
        <h4>Construir el sistema de información</h4>
        <p>Duración: 680 horas | Semanas 1-8</p>
        <ul class="eval-card__list">
            <li><strong>RAP-001:</strong> Identificar requisitos (Sem. 1-3)</li>
            <li><strong>RAP-002:</strong> Construir BD (Sem. 4-6)</li>
            <li><strong>RAP-003:</strong> Codificar módulos (Sem. 7-8)</li>
        </ul>
        <div class="evidencias-tag">
            <span>📝 Conocimiento</span>
            <span>🎭 Desempeño</span>
            <span>📦 Producto</span>
        </div>
    </div>
    <!-- Repetir para cada competencia -->
</div>
```

### Leyenda de Evidencias
```html
<div class="evidencias-legend">
    <h3>Tipos de Evidencias</h3>
    <div class="legend-grid">
        <div class="legend-item">
            <span class="legend-icon">📝</span>
            <div>
                <h4>Conocimiento</h4>
                <p>Quiz, evaluaciones escritas, orales</p>
            </div>
        </div>
        <div class="legend-item">
            <span class="legend-icon">🎭</span>
            <div>
                <h4>Desempeño</h4>
                <p>Simulaciones, observación directa, sustentaciones</p>
            </div>
        </div>
        <div class="legend-item">
            <span class="legend-icon">📦</span>
            <div>
                <h4>Producto</h4>
                <p>Documentos, software, proyectos tangibles</p>
            </div>
        </div>
    </div>
</div>
```

---

## Filtros del Roadmap (Adaptado a SENA)

### HTML de Filtros
```html
<div class="filters">
    <button class="filter-btn active" data-filter="all">📋 Todas</button>
    <button class="filter-btn" data-filter="evaluacion">⭐ Evaluaciones RAP</button>
    <button class="filter-btn" data-filter="pending">⏳ Pendientes</button>
    <button class="filter-btn" data-filter="completed">✅ Completadas</button>
    <button class="filter-btn" data-filter="competencia-1">🎯 Competencia 1</button>
    <button class="filter-btn" data-filter="competencia-2">🎯 Competencia 2</button>
</div>
```

### Lógica de Filtro (JS)
```javascript
function filterWeeks(filter) {
    const weekCards = document.querySelectorAll('.week-card');

    weekCards.forEach(card => {
        let show = true;

        switch (filter) {
            case 'evaluacion':
                show = card.dataset.type === 'evaluacion';
                break;
            case 'pending':
                show = !card.classList.contains('week-card--completed');
                break;
            case 'completed':
                show = card.classList.contains('week-card--completed');
                break;
            case 'competencia-1':
                show = card.dataset.competencia === '1';
                break;
            case 'competencia-2':
                show = card.dataset.competencia === '2';
                break;
            default:
                show = true;
        }

        card.style.display = show ? '' : 'none';
    });
}
```

⚠️ **IMPORTANTE**: El filtro debe usar `data-filter="evaluacion"` para evaluaciones de RAP en SENA.

---

## Persistencia con localStorage

```javascript
const STORAGE_KEY = 'sena_ficha_[numero]_roadmap_progress';

let state = {
    completedWeeks: [],
    unlockedBadges: [],
    rapProgress: {
        'RAP-001': false,
        'RAP-002': false,
        // ...
    },
    competenciasProgress: {
        1: 0, // Porcentaje de avance
        2: 0,
        // ...
    }
};

function loadState() {
    const saved = localStorage.getItem(STORAGE_KEY);
    if (saved) {
        state = JSON.parse(saved);
    }
}

function saveState() {
    localStorage.setItem(STORAGE_KEY, JSON.stringify(state));
}

function updateRAPProgress(rapId, completed) {
    state.rapProgress[rapId] = completed;
    updateCompetenciaProgress();
    saveState();
}

function updateCompetenciaProgress() {
    COURSE_DATA.competencias.forEach(comp => {
        const totalRAP = comp.rap.length;
        const completedRAP = comp.rap.filter(r => state.rapProgress[r.id]).length;
        state.competenciasProgress[comp.id] = Math.round((completedRAP / totalRAP) * 100);
    });
}
```

---

## Checklist de Generación

### Fase 1: Detección
- [ ] Localizar Diseño Curricular o Planeación de la ficha
- [ ] Identificar competencias del programa
- [ ] Extraer RAP por cada competencia
- [ ] Identificar duración en horas de cada competencia
- [ ] Contar número total de semanas por trimestre

### Fase 2: Transformación
- [ ] Crear estructura de semanas por competencia
- [ ] Identificar semanas de evaluación de RAP (type: "evaluacion")
- [ ] Asignar evidencias (conocimiento, desempeño, producto) por semana
- [ ] Definir 6 badges temáticos alineados a RAP y competencias
- [ ] Crear descripciones de fase para cada competencia

### Fase 3: Generación
- [ ] Crear directorio `00-planning/` con subdirectorios `css/` y `js/`
- [ ] Generar `index.html` con estructura SENA
- [ ] Generar `css/styles.css` (colores SENA: naranja #FF5200)
- [ ] Generar `js/app.js` con COURSE_DATA completo

### Fase 4: Verificación
- [ ] Todas las semanas tienen contenido (presencial + virtual + autónomo)
- [ ] Badges tienen iconos y nombres alineados a competencias
- [ ] Filtro de evaluaciones funciona correctamente
- [ ] localStorage usa key única por ficha
- [ ] Sin referencias a parciales o cortes tradicionales
- [ ] Sección de metodología muestra Presencial/Virtual/Autónomo
- [ ] Cada RAP tiene criterios de evaluación claros
- [ ] Evidencias clasificadas correctamente (C/D/P)

---

## Errores Comunes a Evitar

| Error | Solución |
|-------|----------|
| Usar "Corte 1, 2, 3" en lugar de competencias | Estructurar por competencias y RAP |
| Filtro `data-filter="parcial"` | Usar `data-filter="evaluacion"` |
| Badges genéricos ("Semana 5") | Crear badges por logro de RAP/competencias |
| Metodología con Weekly/Planning | Cambiar a Presencial/Virtual/Autónomo |
| Evaluación porcentual (30%, 30%, 40%) | Evaluación cualitativa por evidencias |
| localStorage key sin prefijo ficha | Usar: `sena_ficha_[numero]_roadmap_progress` |
| Semanas sin evidencias definidas | Asignar tipo: conocimiento, desempeño, producto |
| Duración en semanas en lugar de horas | Usar horas totales por competencia |

---

## Comando de Ejecución

```
Crear landing page gamificado para la ficha SENA [NUMERO_FICHA] - [NOMBRE_PROGRAMA].
Ubicación: material-[nombre-programa]/00-planning/

1. Buscar Diseño Curricular en: material-[nombre-programa]/**/diseno-curricular.pdf
2. Si no existe, buscar Planeación: material-[nombre-programa]/**/planeacion-*.xlsx
3. Aplicar metodología SENA POR COMPETENCIAS
4. Generar: index.html, css/styles.css, js/app.js
5. Badges alineados a RAP y competencias de [PROGRAMA]
```

---

## Ejemplo Completo de Ejecución

**Input:**
```
Crear landing page para ADSO - Ficha 2654321
```

**Acciones:**
1. Buscar: `material-adso/**/diseno-curricular.pdf`
2. Si no existe, buscar: `material-adso/**/planeacion-*.xlsx`
3. Leer diseño curricular y extraer:
   - Programa: Análisis y Desarrollo de Software
   - Código: 228106
   - Competencias: 5 competencias específicas
   - Duración total: 2640 horas (24 meses)
   - RAP: ~15 resultados de aprendizaje distribuidos
4. Generar con metodología por competencias
5. Badges: Iniciador ADSO, Analista, Arquitecto BD, Full Stack, Quality Expert, Tecnólogo ADSO

**Output:**
```
material-adso/00-planning/
├── index.html          ✅
├── css/styles.css      ✅ (naranja SENA #FF5200)
└── js/app.js           ✅
```

---

## Paleta de Colores SENA

```css
:root {
    /* Colores principales SENA */
    --sena-orange: #FF5200;
    --sena-orange-dark: #CC4200;
    --sena-orange-light: #FF7A33;
    
    /* Colores secundarios */
    --sena-gray: #58595B;
    --sena-gray-light: #E5E5E5;
    --sena-white: #FFFFFF;
    
    /* Estados */
    --success: #00A651;
    --warning: #FFC72C;
    --error: #ED1C24;
    --info: #0066CC;
}
```

---

## Estructura de Card de Semana (SENA)

```html
<div class="week-card" 
     data-week="1" 
     data-type="normal" 
     data-competencia="1"
     data-rap="RAP-001">
    <div class="week-card__header">
        <div class="week-number">Semana 1</div>
        <div class="week-badges">
            <span class="badge badge--competencia">Comp. 1</span>
            <span class="badge badge--rap">RAP-001</span>
        </div>
    </div>
    
    <h3 class="week-card__title">Introducción a Requisitos</h3>
    <p class="week-card__topic">Levantamiento de información</p>
    
    <div class="week-card__content">
        <div class="content-section">
            <span class="content-label">👨‍🏫 Presencial:</span>
            <p>Clase magistral sobre técnicas de levantamiento</p>
        </div>
        <div class="content-section">
            <span class="content-label">💻 Virtual:</span>
            <p>Video tutorial: Entrevistas efectivas</p>
        </div>
        <div class="content-section">
            <span class="content-label">📚 Autónomo:</span>
            <p>Lectura: IEEE 830 - SRS</p>
        </div>
    </div>
    
    <div class="week-card__evidencias">
        <h4>Evidencias:</h4>
        <div class="evidencias-chips">
            <span class="chip chip--conocimiento">📝 Quiz requisitos</span>
        </div>
    </div>
    
    <div class="week-card__tags">
        <span class="tag">UML</span>
        <span class="tag">Requisitos</span>
        <span class="tag">IEEE 830</span>
    </div>
    
    <button class="week-card__complete-btn" onclick="toggleWeekComplete(1)">
        Marcar como completada
    </button>
</div>
```

---

## Notas Finales

1. **Siempre verificar** las competencias y RAP del diseño curricular antes de generar
2. **Los badges deben reflejar** el logro de RAP y competencias específicas del programa
3. **El filtro de evaluaciones** debe coincidir con el `type` de las semanas
4. **Cada ficha tiene su propia key** de localStorage con número de ficha
5. **Los estilos usan colores SENA** (naranja #FF5200 como principal)
6. **Solo el contenido de `app.js`** cambia entre fichas
7. **Evaluación es permanente** mediante evidencias, no hay parciales tradicionales
8. **Estructura trimestral** con distribución de horas presenciales, virtuales y autónomas

---

## Diferencias Clave: Universidad vs SENA

| Aspecto | Universidad (CORHUILA) | SENA |
|---------|------------------------|------|
| **Evaluación** | Cortes (30%, 30%, 40%) | Competencias y RAP (cualitativa) |
| **Estructura** | Semestral (15-16 semanas) | Trimestral (~18 semanas) |
| **Actividades** | Parcial, taller, quiz, foro | Evidencias: C/D/P |
| **Metodología** | Tradicional o Ágil | Por Competencias |
| **Colores** | Verde/azul CORHUILA | Naranja #FF5200 SENA |
| **Badges** | Por semanas/temas | Por RAP y competencias |
| **Filtros** | Parciales, pendientes | Evaluaciones RAP, competencias |

---

*Prompt SENA v1.0 - Adaptado de versión universitaria v2.0*
*Programas implementables: ADSO, Redes, Multimedia, Logística*