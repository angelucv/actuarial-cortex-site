# Introducción consistente y recomendaciones — Actuarial Cortex y aplicativos

## Propuesta de introducción consistente

Para que todos los aplicativos (Gestión Social, Detección de Fraude, Dashboard Actividad Aseguradora, Demos por sector) se perciban como parte del mismo ecosistema, se recomienda usar **una misma frase de anclaje** y luego una línea específica por app.

### Texto base (común a todos)

**Opción A — Corta**
> **Actuarial Cortex** es un hub de conocimiento y tecnología actuarial. Este aplicativo forma parte de su oferta para [sector/ámbito].

**Opción B — Un poco más larga**
> **Actuarial Cortex** es un hub de conocimiento, tecnología y formación actuarial. Este aplicativo forma parte de Cortex Suite y ofrece [una línea sobre qué hace el demo].

### Por aplicativo (segunda frase)

| Aplicativo | Segunda frase sugerida |
|------------|------------------------|
| **Gestión Social** | Gestión de solicitudes y ayudas sociales: Admin, dashboard con KPIs, mapa por estados y visión histórica. |
| **Detección de Fraude (Banca)** | Análisis de exposición al riesgo (IER) y tasa de fraude por segmentos (marca de tarjeta, categoría de comercio), con métricas ejecutivas para la toma de decisiones. |
| **Dashboard Actividad Aseguradora** | Inteligencia de datos del sector asegurador (SUDEASEG): primas, siniestros y análisis por empresa y ramo. |
| **Demos por sector (Cortex Suite)** | Demos interactivos por sector (banca, seguros, retail, salud, control) con analítica, cuadros de mando y modelos con datos simulados. |
| **Tarificación telemática** | Uso de variables telemáticas para frecuencia y severidad, segmentación de riesgo y tarificación en seguros auto. |

### Dónde colocarla

- **Streamlit:** Debajo del logo principal (o en la primera celda de contenido), en un `st.markdown()` con el texto base + la línea específica. Incluir un enlace clicable en «Actuarial Cortex» a `https://actuarial-cortex.pages.dev/`.
- **Django (Gestión Social):** En la página de inicio del Admin (`cortex_index.html`) y/o en la cabecera del Dashboard; una línea bajo el título con el texto base y enlace al sitio.
- **Sitio web (Cortex Suite):** El párrafo introductorio de la página Cortex Suite ya enlaza al hub; mantener el mismo tono (conocimiento, tecnología, formación) en las descripciones de cada demo.

---

## Recomendaciones por ámbito

### Sitio web (actuarial-cortex.pages.dev)

- Mantener **un solo punto de entrada** a los demos (Cortex Suite): barra de botones + tabla con enlaces. Evitar duplicar los mismos enlaces en el inicio para no romperlos en un solo lugar.
- En **Cortex Suite**, dejar visible el enlace al **mapa de aplicativos** (`docs/ACTUARIAL_CORTEX_APLICATIVOS.md` en GitHub) para desarrolladores y mantenimiento.
- Revisar de forma periódica que todas las URLs externas (Streamlit, HF, Shiny) sigan funcionando.
- Usar **títulos y meta descripciones** coherentes (incluir “Actuarial Cortex” donde tenga sentido) para SEO.

### Aplicativos (demos)

- **Enlace a Actuarial Cortex en todas las páginas:** En el menú lateral (sidebar) o en un pie fijo, incluir siempre un enlace «Ir a Actuarial Cortex» a `https://actuarial-cortex.pages.dev/`. Así el usuario puede volver al hub desde cualquier pantalla.
- **Logo + texto:** Mantener logo de Actuarial Cortex (principal o vertical) en inicio y/o sidebar, y la línea de introducción consistente debajo.
- **Pie unificado:** En el sidebar (o al final de la página principal), usar el mismo bloque: © Actuarial Cortex, Conocimiento · Tecnología · Formación, contacto (email y @actuarial_cortex).
- **Nuevos demos:** Al añadir un aplicativo, actualizar la tabla en `docs/ACTUARIAL_CORTEX_APLICATIVOS.md` y el bloque de demos en la página Cortex Suite del sitio.

### Gestión Social (Django)

- El **Dashboard** ya incluye el botón «Ir a Actuarial Cortex»; el **Admin** tiene el enlace en la barra de usuario y en el footer (© Actuarial Cortex clicable). En la página de inicio del Admin (`cortex_index.html`) está el acceso rápido «Ir a Actuarial Cortex». Con esto se cubre inicio y todas las páginas.
- Si se añaden más plantillas propias (fuera del Admin), reutilizar el mismo enlace en cabecera o pie.

### Detección de Fraude e Insurdata (Streamlit)

- **Sidebar:** Enlace «Ir a Actuarial Cortex» cerca del logo o antes del pie.
- **Área principal:** Primera línea con «Actuarial Cortex» enlazada al sitio y la descripción corta del demo (según la tabla de arriba).

---

## Resumen de enlaces a Actuarial Cortex por aplicativo

| Aplicativo | Dónde está el enlace |
|------------|------------------------|
| **Sitio web** | N/A (es el hub). |
| **Gestión Social** | Dashboard: botón «Ir a Actuarial Cortex». Admin: userlinks + footer + acceso rápido en inicio Admin. |
| **Detección de Fraude** | Sidebar: «Ir a Actuarial Cortex». Inicio: «Actuarial Cortex» clicable en el párrafo. |
| **Dashboard Actividad Aseguradora** | Sidebar: «Ir a Actuarial Cortex» (en el pie unificado). |
| **Cortex Suite (demos)** | Sidebar y barra superior: «Ir a Actuarial Cortex». Texto con enlace al sitio. |

Actualizar este documento si se añaden nuevos aplicativos o se cambia la URL del sitio.
