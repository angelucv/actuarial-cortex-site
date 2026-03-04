## Actuarial Cortex — Hub de Conocimiento y Tecnología Actuarial

**Actuarial Cortex** es un **hub personal de conocimiento y tecnología actuarial** impulsado por el Prof. **Angel Colmenares** (EECA–UCV). Nace como un espacio donde convergen:

- **Conocimiento aplicado**: modelos de mortalidad, solvencia, pensiones, tarificación, riesgo financiero, series de tiempo y ciencia de datos aplicados al sector asegurador y previsional.
- **Tecnología**: demos y herramientas en R, Python y plataformas web (Shiny, Streamlit, dashboards, mapas de riesgo, Cortex Suite).
- **Formación**: cursos, materiales docentes, rutas de aprendizaje y documentación para estudiantes, actuarios y profesionales del sector.

Este repositorio contiene el **código fuente del portal web de Actuarial Cortex**, construido con **Quarto** y pensado para desplegarse en plataformas estáticas (por ejemplo, **Cloudflare Pages**).

---

## ¿Qué ofrece la web de Actuarial Cortex?

La web generada a partir de este repositorio organiza el contenido del hub en secciones claras:

### Inicio

- Presentación del hub **Actuarial Cortex** (Conocimiento – Tecnología – Formación).
- Bloques de navegación rápida hacia:
  - Investigación
  - Docencia (cursos)
  - Servicios / Demos
  - Observatorio
  - Cortex Suite
  - Resources (materiales académicos)
- Titulares recientes del sector (“seguros”, “actuarial”) obtenidos de Google News.

### Sobre Cortex

- Explica el contexto institucional:
  - Centro Venezolano de Estudios Actuariales (CVEA).
  - Escuela de Estadística y Ciencias Actuariales (EECA–UCV).
- Detalla los **tres ejes** del hub:
  - Investigación aplicada.
  - Tecnología y demos.
  - Formación continua y materiales docentes.

### Miembros

- Perfiles del equipo central, colaboradores y tesistas.
- Permite entender quién está detrás de los proyectos, artículos, cursos y demos.

### Cortex Suite

- Sección para la **suite de soluciones analíticas** del hub:
  - Banca (riesgo de crédito, scoring, comportamiento de portafolios).
  - Seguros (tarificación, reservas, siniestralidad).
  - Salud (gastos médicos, auditoría de facturas, solvencia técnica).
  - Retail / Industria (analítica de demanda, mantenimiento, OEE).
- Resume cada módulo y enlaza a los **demos en línea** cuando están disponibles.

### Docencia / Portal de cursos

- **Landing de cursos**:
  - Hero con diseño de plataforma de cursos.
  - Botón destacado “Abrir Portal de Cursos”.
- Descripción de la **oferta formativa**:
  - Módulos de R y Python aplicados a datos actuariales y financieros.
  - Modelado actuarial, reservas, series de tiempo, machine learning.
- Página específica del **Curso de Series de Tiempo con Python**:
  - A quién va dirigido (actuarios, analistas).
  - Qué capacidades se desarrollan (proyección de mortalidad, siniestralidad, indicadores económicos).

### Investigación y Model Hub

- Página de **Investigación**:
  - Explica que el eje se articula a través de:
    - **Resources**: materiales académicos con revisión editorial.
    - **Model Hub**: repositorio de scripts R/Python, hojas de Excel actuarial y bases de datos abiertas para replicación.
  - Indica que los **Trabajos Finales de Pregrado (TFPG)** donde el Prof. Angel Colmenares ha sido tutor (y los tesistas aceptan publicación) se integran en Resources como artículos/capítulos derivados.

- Página del **Model Hub**:
  - Describe el contenido previsto:
    - Scripts R/Python (Lee-Carter, BYM/INLA, IBNR, proyecciones demográficas, etc.).
    - Plantillas Excel actuariales.
    - Datasets usados en artículos y cursos.
  - Conecta con:
    - `Resources` (artículos con código reproducible).
    - `Docencia` (uso pedagógico del Model Hub).

### Resources (Materiales académicos)

- Hero: **“Materiales Académicos del Actuarial Cortex Hub”**.
- Sección **Curso de Series de Tiempo**:
  - Breve descripción del curso.
  - Enlace directo a la página de docencia.
- Sección **Plantilla de Libros y Materiales Docentes**:
  - Explica que los libros del hub se basan en una plantilla **Quarto Book** inspirada en *Applied Machine Learning Using mlr3 in R*.
  - Enlace de descarga a `mlr3book.pdf` (libro de referencia) ubicado en `resources/`.
- `resources/articulos.qmd`:
  - Lista artículos por volumen, con títulos, autores y enlaces HTML/PDF.
- `resources/portal.qmd`:
  - Tablero interno con el plan editorial y el estado de cada manuscrito (Listo/Borrador/Pendiente).

### Servicios y Demos

- **Servicios**:
  - Describe la oferta de consultoría y la vinculación con el sector:
    - Valoración actuarial.
    - Proyectos de analítica y ciencia de datos.
    - Asesorías para reguladores y aseguradoras.
- **Demos**:
  - `demo-mapa.qmd`: demo del **Mapa de riesgo de mortalidad**.
  - `demo-ibnr.qmd`: demo de reservas **IBNR**.

### Observatorio

- Presenta el **Observatorio de variables actuariales**:
  - Variables biométricas:
    - Tablas dinámicas de mortalidad, SMR, clusters de riesgo, proyecciones Lee-Carter.
  - Variables financieras:
    - Inflación actuarial, tasas técnicas de descuento para reservas y pensiones.
  - Variables de previsión:
    - Indicadores de solvencia y sostenibilidad de regímenes de previsión social.
- Indica que se apoyará en dashboards, boletines e investigación publicada en Resources.

### Actualidad

- Tabla de **novedades** (nuevos artículos, cursos, secciones del sitio).
- Noticias del sector en tiempo real (Google News RSS).
- Call for Papers simplificado que remite a la sección de Resources.

### Contacto

- Organiza los canales de contacto por tipo de consulta:
  - Consultoría y servicios.
  - Investigación / TFPG.
  - Materiales académicos (Resources).
  - Formación y cursos.
- Incluye correos e Instagram del hub, además de enlaces a la página de Miembros.

---

## Despliegue

Hay dos formas de publicar el sitio en **Cloudflare Pages**:

### 1. Build en Cloudflare (sin R)

En **Cloudflare Pages → Settings → Builds** usa:

- **Build command:**  
  `curl -L https://github.com/quarto-dev/quarto-cli/releases/download/v1.5.57/quarto-1.5.57-linux-amd64.tar.gz -o quarto.tar.gz && tar -xzf quarto.tar.gz && ./quarto-1.5.57/bin/quarto render --to html --no-execute`
- **Build output directory:** `_site`

No se ejecuta código R; las noticias en Inicio y Actualidad se sustituyen por enlaces a Google Noticias.

### 2. Build con R en GitHub Actions (recomendado)

El workflow **`.github/workflows/deploy-pages.yml`** instala **R** y **Quarto**, renderiza el sitio (con ejecución de código R) y sube `_site` a Cloudflare Pages.

**Pasos:**

1. En GitHub: **Settings → Secrets and variables → Actions**, crea:
   - `CLOUDFLARE_API_TOKEN`: token con permiso *Cloudflare Pages — Edit* (desde [API Tokens](https://dash.cloudflare.com/profile/api-tokens)).
   - `CLOUDFLARE_ACCOUNT_ID`: ID de cuenta (panel de Cloudflare, columna derecha).
2. Si tu proyecto en Pages no se llama `actuarial-cortex-site`, edita en el workflow la línea `--project-name=...` con el nombre correcto.
3. Opcional: en Cloudflare Pages, desactiva el build por Git para evitar builds duplicados y usar solo el despliegue desde Actions.

Cada push a `main` construye el sitio con R (incluido el feed de noticias) y despliega a Cloudflare Pages.

---

## Estructura detallada del repositorio

La raíz del repositorio (`actuarial-cortex-site`) se ve aproximadamente así:

```text
actuarial-cortex-site/
├─ _quarto.yml
├─ _website.yml
├─ _format.yml
├─ _brand.yml
├─ .gitignore
├─ index.qmd
├─ sobre-cortex.qmd
├─ miembros.qmd
├─ cortex-suite.qmd
├─ observatorio.qmd
├─ actualidad.qmd
├─ contacto.qmd
├─ docencia/
├─ investigacion/
├─ resources/
├─ servicios/
├─ Referencias/
├─ assets/
├─ logo-AC/
├─ site_libs/
└─ _site/
```

### Configuración global (Quarto y navegación)

- **`_quarto.yml`**  
  Orquesta todo el sitio:

  - Define el proyecto como website:
    - `project.type: website`
    - `output-dir: _site` (directorio donde Quarto deja el HTML final).
  - Indica recursos que deben copiarse tal cual:
    - `assets/articulos`
    - `Referencias/Recursos_HTML`
    - `apps/cvea-suite-demos`
    - `logo-AC`
  - Lista las páginas y secciones a renderizar:
    - Páginas raíz: `index.qmd`, `sobre-cortex.qmd`, `miembros.qmd`, `cortex-suite.qmd`, `observatorio.qmd`, `actualidad.qmd`, `contacto.qmd`.
    - Directorios completos: `investigacion`, `resources`, `docencia`, `servicios`.

- **`_website.yml`**  
  Controla la navegación y el footer:

  - `website.title`: nombre del sitio (Actuarial Cortex).
  - Barra de navegación (navbar):
    - Logo (ruta a `logo-AC/logo-ac-blanco.png`).
    - Menú desplegable “Menú” con entradas:
      - `Inicio`, `Sobre Cortex`, `Miembros`, `Resources`, `Model Hub`, `Cursos`, `Cortex Suite`, `Servicios`, `Observatorio`, `Actualidad`, `Contacto`.
    - Menú derecho con iconos (Bootstrap Icons):
      - `house-fill` → Inicio.
      - `building` → Sobre Cortex.
      - `people-fill` → Miembros.
      - `grid-3x3-gap` → **Cortex Suite**.
      - `journal-bookmark-fill` → **Portal de cursos** (Docencia).
  - Footer común:
    - Lado izquierdo: `© Actuarial Cortex`.
    - Centro: “Conocimiento - Tecnología - Formación”.
    - Lado derecho: correos e Instagram del hub.

- **`_format.yml`**  
  Define el estilo global del HTML:

  - Tema: `spacelab`.
  - Paleta de colores personalizada (cortex-dark, cortex-mid, cortex-bright, etc.).
  - Fuentes: `Montserrat` (texto principal) y `Fira Code` (código).
  - CSS global: `assets/styles.css`.
  - Archivos incluidos en `<head>`:
    - Meta tags (`assets/meta.html`).
    - Navbar personalizada (`assets/navbar-menu-panel.html`, etc.).
    - Configuración de MathJax, doodle, etc.

- **`_brand.yml`**  
  Reúne configuraciones de marca (texto y logos) para PDF/HTML y otros outputs.

---

## Páginas raíz (`*.qmd` en la raíz del repo)

- **`index.qmd`**  
  Página de inicio:
  - Hero con fondo animado y logo Actuarial Cortex.
  - Textos rotativos con áreas de trabajo (Actuaría, Pensiones, Riesgo financiero, etc.).
  - Botón “Conocer más” que baja al bloque académico.
  - Bloques de “Ejes Académicos” y “Gestión y Vinculación”:
    - Investigación, Docencia, Extensión, Observatorio.
    - Tiles que enlazan a `Resources`, `Cursos`, `Cortex Suite`, `Actualidad`, `Contacto`.
  - Sección “Inicio — Identidad y propósito” con enlaces rápidos a todas las secciones del sitio.

- **`sobre-cortex.qmd`**  
  Presenta la identidad de Actuarial Cortex, su relación con la EECA–UCV y los ejes del hub.

- **`miembros.qmd`**  
  Contiene el detalle del equipo:
  - Comité central.
  - Colaboradores.
  - Tesistas y autores vinculados.

- **`cortex-suite.qmd`**  
  Página de producto/servicio:
  - Describe cada módulo de la suite (Banca, Seguros, Salud, Retail, Industria).
  - Explica qué tipo de datos y modelos se usan.
  - Enlaza a demos implementados en Streamlit o Shiny.

- **`observatorio.qmd`**  
  Página del observatorio:
  - Describe las variables monitoreadas (biométricas, financieras, previsión).
  - Explica el vínculo con la investigación en Resources y con dashboards futuros.

- **`actualidad.qmd`**  
  Página de noticias y agenda:
  - Tabla de novedades.
  - Bloque RSS de Google News para “seguros actuarial”.
  - Enlaces a noticias, fuentes sectoriales y revistas relevantes.
  - Call for Papers resumido apuntando a Resources.

- **`contacto.qmd`**  
  Organiza los canales de contacto:
  - Para consultoría y asesoría.
  - Para investigación y TFPG.
  - Para publicaciones en Resources.
  - Para formación y cursos.
  - Incluye correos del hub e Instagram.

---

## Carpetas de contenido

### `docencia/`

- **`docencia/index.qmd`**  
  - Hero de “Plataforma de cursos (Moodle)”.
  - Botón “Abrir Portal de Cursos”.
  - Descripción de los módulos de formación (fundamentos analíticos, ingeniería de datos, modelado actuarial, ML).
  - Resumen de por qué estudiar con el hub.

- **`docencia/series-tiempo/index.qmd`**  
  - Ficha del **Curso de Series de Tiempo con Python**:
    - Público objetivo.
    - Temario.
    - Enfoque aplicado (proyecciones de mortalidad, siniestralidad, indicadores económicos).

- **`docencia/plataforma-cursos/*`**  
  - Documentación técnica para montar la plataforma de cursos:
    - Fase 1: infraestructura (por ejemplo, VM + Moodle).
    - Fase 2: diseño de cursos.
    - Alternativas a Oracle, etc.

### `investigacion/`

- **`investigacion/index.qmd`**  
  - Explica el **eje de Investigación**:
    - Resources (materiales académicos).
    - Model Hub (scripts, Excel actuarial, bases de datos).
  - Indica que los TFPG donde el Prof. Angel Colmenares ha sido tutor y hay acuerdo de publicación se listan en Resources.

- **`investigacion/model-hub.qmd`**  
  - Detalla el **Model Hub**:
    - Scripts R/Python (Lee-Carter, BYM/INLA, IBNR, etc.).
    - Excel actuariales.
    - Datasets usados en artículos y cursos.
  - Enlaces relacionados:
    - `../resources/index.qmd` (materiales académicos).
    - `../docencia/index.qmd#recursos` (uso pedagógico del Model Hub).

### `resources/`

- **`resources/index.qmd`**  
  - Hero “Materiales Académicos del Actuarial Cortex Hub”.
  - Sección **Curso de Series de Tiempo**:
    - Explicación breve.
    - Enlace a `../docencia/series-tiempo/index.qmd`.
  - Sección **Plantilla de Libros y Materiales Docentes**:
    - Explica la base Quarto Book, inspirada en *Applied Machine Learning Using mlr3 in R*.
    - Enlace de descarga a `mlr3book.pdf` (archivo que resides en `resources/`).

- **`resources/articulos.qmd`**  
  - Lista artículos por volumen:
    - Título, autores, descripción breve.
    - Enlaces HTML/PDF (externos o internos).

- **`resources/portal.qmd`**  
  - Tablas que muestran:
    - Volúmenes previstos.
    - Estado de cada manuscrito (Listo, Borrador, Pendiente).
    - Rutas de acceso y carpetas en el repositorio editorial.

- **`resources/vol1-*.qmd`**  
  - Fichas específicas de artículos (Colmenares, Moreno Arlet, Azuaje, etc.), con resumen, contexto, métodos y palabras clave.

### `servicios/`

- **`servicios/index.qmd`**  
  - Resume los **servicios de consultoría** y las líneas de trabajo práctico del hub.
  - Presenta brevemente los demos disponibles.

- **`servicios/demo-mapa.qmd`**  
  - Página dedicada al demo de **mapa de riesgo de mortalidad**.

- **`servicios/demo-ibnr.qmd`**  
  - Página para el demo de **reservas IBNR** en Streamlit.

---

## `Referencias/` (material interno y plantillas)

La carpeta `Referencias/` concentra una gran cantidad de material de apoyo:

- Plantillas de libro (Quarto Book) basadas en *Applied Machine Learning Using mlr3 in R*.
- Plantillas de la revista RVEA.
- HTMLs de referencia que se sirven desde `Referencias/Recursos_HTML`.
- Documentos, ejercicios, parciales y notas del curso de Matemáticas Actuariales I, etc.

Para evitar problemas de tamaño y de rutas largas en Git:

- En `.gitignore` se han excluido explícitamente:
  - `Referencias/Actuariales I/Matemáticas Actuariales I PL II-2024 (Documentos)/`
  - `Referencias/Financieras I/` (colección de libros “Financieras I”).

El resto de `Referencias/` sí forma parte del repositorio y se puede usar para:

- Generar libros propios (ej. Introducción a las Matemáticas Actuariales, Matemáticas Financieras).
- Consultar plantillas editables y material de referencia.

---

## Assets y salida del sitio

- **`assets/`**  
  Contiene:

  - `assets/styles.css`: capa de estilo del portal (tipografías, colores, layout de heroes, bloques, etc.).
  - HTMLs parciales para navbar, meta tags, doodle, etc.
  - JS para efectos de texto rotativo y animaciones.

- **`logo-AC/`**  
  Logos en diferentes variantes (blanco, color, horizontal, vertical) usados en:
  - Hero de la home.
  - Barra de navegación.
  - Otras secciones.

- **`site_libs/`**  
  Librerías generadas por Quarto (Bootstrap, MathJax, etc.) que acompañan el HTML renderizado.

- **`_site/`**  
  Directorio de salida:

  - Cuando ejecutas `quarto render`, todo el HTML final se genera en `_site/`.
  - Es el directorio que **Cloudflare Pages** utiliza como output para servir la web.

---

## `.gitignore` y tamaño del repositorio

El `.gitignore` actual incluye:

```text
/.quarto/
# Carpeta con rutas demasiado largas para Git en Windows
/Referencias/Actuariales I/Matemáticas Actuariales I PL II-2024 (Documentos)/
# Carpeta Financieras I (libros fuente, no se versionan)
/Referencias/Financieras I/
```

Esto asegura que:

- No se suben caches ni metadatos de Quarto (`.quarto/`).
- No se suben carpetas con:
  - Rutas demasiado largas para Windows (que rompen `git add`).
  - Colecciones de libros muy pesadas (como los PDFs de `Financieras I`), que harían el repo enorme y provocarían errores de push o límites de GitHub.

El resultado es un repositorio:

- Lo suficientemente **completo** para reconstruir el sitio web y los materiales.
- Lo suficientemente **ligero** para trabajar cómodamente con GitHub y servicios de despliegue continuo (como Cloudflare Pages).

