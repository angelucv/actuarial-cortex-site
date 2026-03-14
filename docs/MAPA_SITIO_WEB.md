# Mapa general del sitio web — Actuarial Cortex

Estructura de la web [actuarial-cortex.pages.dev](https://actuarial-cortex.pages.dev). Actualizar cuando se añadan o quiten páginas o secciones.

---

## 1. Navegación principal (navbar)

**Menú desplegable (Menú):**

| Texto          | Página / ruta                    |
|----------------|----------------------------------|
| Inicio         | `index.html`                     |
| Sobre Cortex   | `sobre-cortex.html`              |
| Miembros       | `miembros.html`                  |
| Resources      | `resources/index.html`          |
| Model Hub      | `investigacion/model-hub.html`   |
| Cursos         | `docencia/index.html`           |
| Cortex Suite   | `cortex-suite.html`              |
| Servicios      | `servicios/index.html`          |
| Observatorio   | `observatorio.html`             |
| Actualidad     | `actualidad.html`               |
| Contacto       | `contacto.html`                 |

**Iconos derecha (acceso rápido):** Inicio · Sobre Cortex · Cortex Suite · Miembros · Portal de cursos · Correo · Instagram.

---

## 2. Páginas raíz (una por archivo .qmd en raíz)

| Archivo           | URL resultante        | Título (pestaña)              |
|-------------------|------------------------|-------------------------------|
| `index.qmd`       | `/`                    | Inicio \| Actuarial Cortex    |
| `sobre-cortex.qmd`| `/sobre-cortex.html`   | Sobre Cortex \| Actuarial Cortex |
| `miembros.qmd`    | `/miembros.html`       | Miembros \| Actuarial Cortex  |
| `cortex-suite.qmd`| `/cortex-suite.html`   | Cortex Suite \| Actuarial Cortex |
| `actuarial-suite.qmd` | `/actuarial-suite.html` | Actuarial Suite \| Actuarial Cortex |
| `observatorio.qmd`| `/observatorio.html`   | Observatorio \| Actuarial Cortex |
| `actualidad.qmd`  | `/actualidad.html`     | Actualidad \| Actuarial Cortex |
| `contacto.qmd`    | `/contacto.html`       | Contacto \| Actuarial Cortex  |

*Nota:* Actuarial Suite existe como página pero no está en el navbar; se puede enlazar desde Cortex Suite o desde el inicio si se desea.

---

## 3. Secciones con subpáginas

### 3.1 Resources (`/resources/`)

| Página        | URL                              | Contenido principal                    |
|---------------|-----------------------------------|----------------------------------------|
| Index         | `/resources/index.html`          | Curso Series de Tiempo, Plantilla libros, enlace Insurdata |
| Artículos     | `/resources/articulos.html`      | Listado de artículos por volumen       |
| Portal        | `/resources/portal.html`         | Plan editorial y estado de manuscritos |
| Vol1/Vol2 (artículos) | `/resources/vol1-*.html`, `vol2-*.html` | Fichas de artículos concretos   |

### 3.2 Investigación (`/investigacion/`)

| Página   | URL                                |
|----------|------------------------------------|
| Index    | `/investigacion/index.html`        |
| Model Hub| `/investigacion/model-hub.html`    |

### 3.3 Docencia / Cursos (`/docencia/`)

| Página            | URL                                      |
|-------------------|------------------------------------------|
| Index (Cursos)    | `/docencia/index.html`                   |
| Series de Tiempo  | `/docencia/series-tiempo/index.html`     |
| Plataforma cursos | `/docencia/plataforma-cursos/index.html` |
| Fase 1, Alternativas | `/docencia/plataforma-cursos/fase1-pasos.html`, `alternativas-oracle.html` |

### 3.4 Servicios (`/servicios/`)

| Página  | URL                     | Nota                                  |
|---------|-------------------------|----------------------------------------|
| Index   | `/servicios/index.html` | Consultoría, demos (enlace a Cortex Suite), Insurdata |
| Demo IBNR  | `/servicios/demo-ibnr.html`  | Ya no enlazado desde Servicios; solo por URL directa |
| Demo Mapa  | `/servicios/demo-mapa.html`  | Ya no enlazado desde Servicios; solo por URL directa |

---

## 4. Cortex Suite — Demos desplegados (tabla con botón «Ir»)

Todos los aplicativos en línea se abren desde **Cortex Suite** (`/cortex-suite.html`):

| Demo                         | Enlace (externo) |
|-----------------------------|------------------|
| Dashboard Actividad Aseguradora | insurdata-dashboard.streamlit.app |
| Gestión Social              | angelucv-actuarial-cortex-gestion-social.hf.space |
| Detección de Fraude (Banca) | angelucv-actuarial-cortex-bank-fraud.hf.space |
| Demos por sector            | actuarial-cortex-demos.streamlit.app |

Barra de botones en la misma página: Demos por sector · Dashboard Actividad Aseguradora · Gestión Social · Detección de Fraude · Tarificación telemática (Shiny).

---

## 5. Estructura de carpetas (fuente .qmd)

```
actuarial-cortex-site/
├── index.qmd, sobre-cortex.qmd, miembros.qmd, cortex-suite.qmd,
├── actuarial-suite.qmd, observatorio.qmd, actualidad.qmd, contacto.qmd
├── _website.yml, _quarto.yml, _format.yml, _brand.yml
├── assets/          (estilos, og-meta, js)
├── logo-AC/         (logos PNG y WebP)
├── resources/       (index, articulos, portal, vol1-*, vol2-*)
├── investigacion/   (index, model-hub)
├── docencia/        (index, series-tiempo, plataforma-cursos)
├── servicios/       (index, demo-mapa, demo-ibnr)
├── docs/            (documentación interna: este mapa, mejoras, etc.)
└── Referencias/     (material de apoyo, no todo en navegación)
```

---

## 6. Pie de página (global)

- Izquierda: © Actuarial Cortex  
- Centro: Conocimiento - Tecnología - Formación  
- Derecha: actuarial.cortex@gmail.com · @actuarial_cortex  

---

*Última actualización: según commit que incluye títulos con "| Actuarial Cortex", botones "Ir" en tabla Demos, y Servicios sin Demo Mapa/IBNR en la galería.*
