# Mejoras sugeridas — Página web y aplicativos (proyecto Actuarial Cortex)

Documento de referencia con mejoras priorizadas para el sitio web y los demos como proyecto conjunto. Actualizar según avances y prioridades.

---

## 1. Página web (actuarial-cortex.pages.dev)

### 1.1 SEO y descubribilidad
- **Meta descripción y Open Graph:** Definir `description` y etiquetas OG por página (o por defecto en `_quarto.yml`) para que al compartir en redes se vea título, descripción e imagen.
- **URL canónica:** Si usas dominio propio además de `pages.dev`, indicar canonical para evitar contenido duplicado. *Cómo:* en `assets/og-meta.html` se incluye `<link rel="canonical" href="https://actuarial-cortex.pages.dev/">`; si cambias de dominio, actualiza esa URL.
- **Sitemap:** Quarto genera `sitemap.xml` al construir el sitio cuando en `_website.yml` está definido `site-url`. *Cómo:* el archivo `robots.txt` en la raíz del proyecto se copia a `_site` (vía `resources` en `_quarto.yml`) y debe contener `Sitemap: https://actuarial-cortex.pages.dev/sitemap.xml` para que los buscadores encuentren el sitemap.
- **Títulos por página:** Revisar que cada `.qmd` tenga un `title` claro y que incluya "Actuarial Cortex" donde ayude (ej. "Cortex Suite | Actuarial Cortex").

### 1.2 Rendimiento y técnico
- **Imágenes (WebP):** Usar formatos modernos (WebP) donde sea posible y tamaños adecuados; lazy loading si hay muchas imágenes en una página. *Cómo:* (1) Convertir PNG/JPG a WebP (herramientas: `cwebp` de Google, ImageMagick, o sitios como squoosh.app). (2) En HTML usar `<picture>`: `<picture><source srcset="logo.webp" type="image/webp"><img src="logo.png" alt="..."></picture>` para que navegadores compatibles carguen WebP y el resto use el fallback. (3) Opcional: en Quarto, incluir en el header un bloque condicional por página para las imágenes críticas (hero, logo).
- **Recursos externos:** Los CDN (animate.css, lord-icon, etc.) están bien; valorar cargar solo lo necesario o self-host si quieres menos dependencias.
- **Build:** Revisar que `_site` y `site_libs` no se suban al repo si Cloudflare construye desde el repo (build desde Quarto en CI); así el repo queda más ligero.

### 1.3 Accesibilidad
- **Contraste y fuentes:** Verificar ratio de contraste en textos (especialmente en hero y pies) y que el tamaño de fuente sea legible en móvil.
- **Navegación por teclado y ARIA:** Menús y enlaces accesibles por tab; `aria-label` en iconos del navbar (ya tienes algunos).
- **Enlaces:** Que todos los enlaces tengan texto o `aria-label` descriptivo (evitar "clic aquí" sin contexto).

### 1.4 Contenido y UX
- **Cortex Suite como hub:** La página Cortex Suite ya concentra los demos; mantener un solo listado actualizado (tabla + botones) y enlazar desde ahí al mapa de aplicativos en GitHub.
- **Contacto:** Si hay formulario, indicar qué se hace con los datos; si solo mailto/Instagram, está claro.
- **Actualidad:** Si los titulares de Google News fallan a veces, tener un fallback (mensaje amigable o últimos 3–5 enlaces estáticos) para no dejar la sección vacía.

### 1.5 Móvil
- **Menú colapsable:** El navbar ya colapsa; revisar que en móvil la navegación sea cómoda y que las tarjetas de "Explora el hub" apilen bien.
- **Tablas:** En Cortex Suite y demás, si hay tablas anchas, valorar diseño responsive (scroll horizontal o columnas prioritarias en móvil).

---

## 2. Aplicativos (demos)

### 2.1 Consistencia (ya avanzada)
- Mantener **texto de inicio** común ("Actuarial Cortex es un hub…") y **pie unificado** (© Actuarial Cortex, tagline, contacto) en todos.
- **Enlace "Ir a Actuarial Cortex"** en sidebar o pie de cada demo.
- **Mapa de aplicativos** actualizado al añadir o quitar demos; documento "Cómo no perder las rutas" en uso.

### 2.2 Experiencia de uso
- **Carga inicial:** En Streamlit/HF, la primera carga puede ser lenta (p. ej. descarga de datos); un mensaje tipo "Cargando…" o un spinner mejora la percepción.
- **Errores amigables:** Si un demo falla (API, dato faltante), mostrar un mensaje claro y, si aplica, enlace a Actuarial Cortex o a contacto. *Cómo (Streamlit):* envolver la carga de datos en `try/except` y usar `st.error("...")` + `st.stop()` con un texto tipo "No se pudieron cargar los datos. Intente más tarde o contacte a [Actuarial Cortex](url).". *Cómo (Django):* opcionalmente una plantilla `500.html` personalizada con mensaje amigable y enlace al sitio.
- **Datos de ejemplo:** Dejar claro en cada demo que son "datos de demostración" o "simulados" cuando corresponda, para no generar malentendidos.

### 2.3 Técnico
- **Variables de entorno:** Secretos (tokens, DB) fuera del código; en HF/Streamlit usar secrets/variables del entorno.
- **Logs y salud:** En Django (Gestión Social), revisar que en producción no se expongan trazas sensibles y que `DEBUG` esté en `False`; opcional: endpoint de salud para monitoreo. *Cómo (Django):* vista que responda `JsonResponse({"status": "ok"}, status=200)` en una ruta tipo `/health/`; en Hugging Face / Streamlit no suele hacerse endpoint propio (la plataforma hace health checks).
- **Dependencias:** Fijar versiones en `requirements.txt` (o `environment.yml`) en cada app para builds reproducibles.

### 2.4 Documentación interna
- **README por app:** En cada repo (Insurdata, Bank Fraud, Gestión Social, Cortex Suite), un README breve: qué es, cómo ejecutarlo en local, cómo desplegar y enlace al sitio Actuarial Cortex.
- **Changelog ligero:** Un `CHANGELOG.md` o sección en README con fechas y cambios relevantes ayuda a mantener el historial del proyecto. *Cómo:* en la raíz del repo del sitio hay `CHANGELOG.md`; usar formato tipo "Añadido / Cambiado / Corregido" y fechas o versiones.

---

## 3. Proyecto en conjunto

### 3.1 Documentación central
- **docs/ en el sitio:** Ya tienes `ACTUARIAL_CORTEX_APLICATIVOS.md`, `INTRODUCCION_CONSISTENTE_Y_RECOMENDACIONES.md` y este archivo; mantenerlos como referencia única y enlazarlos desde el README del sitio.
- **Un "Estado del proyecto":** Opcional: un `ESTADO_PROYECTO.md` o sección en README con: qué está en producción, qué está en beta y qué está planeado (Cortex Suite, Gestión Social, Insurdata, etc.).

### 3.2 CI/CD y despliegue
- **Sitio:** Cloudflare Pages construye desde el repo; asegurar que el comando de build (Quarto) y la carpeta de salida estén bien configurados.
- **Gestión Social / Bank Fraud:** GitHub Actions sincronizan con HF; revisar que los secrets (HF_TOKEN, etc.) estén configurados y que el workflow falle de forma clara si algo falla.
- **Insurdata y Cortex Suite (Streamlit):** Confirmar que el "Main file path" y la rama en Streamlit Cloud coinciden con el repo; documentar en el mapa de aplicativos.

### 3.3 Monitoreo y mantenimiento
- **Checklist de revisión trimestral:** Ver la sección "Revisión trimestral" en [ACTUARIAL_CORTEX_APLICATIVOS.md](ACTUARIAL_CORTEX_APLICATIVOS.md).
- **Enlaces rotos:** Revisar de tanto en tanto que los enlaces desde el sitio a los demos (Streamlit, HF, Shiny) sigan activos; se puede hacer a mano o con una herramienta de broken-link check.
- **Versiones de frameworks:** Quarto, Django, Streamlit y R/Shiny tienen actualizaciones; planificar actualizaciones menores (parches) para seguridad y compatibilidad.

### 3.4 Crecimiento futuro
- **Nuevos demos:** Al sumar un demo, actualizar: (1) tabla en `ACTUARIAL_CORTEX_APLICATIVOS.md`, (2) página Cortex Suite (botones/tabla), (3) texto de inicio del nuevo app según la guía de introducción consistente.
- **Dominio propio:** Si en algún momento usas dominio propio para el sitio, unificar enlaces (sitio y demos que apunten al hub) y actualizar `ACTUARIAL_CORTEX_APLICATIVOS.md` y configs (p. ej. `site-url` en Quarto).
- **Analytics y feedback:** Opcional: analytics ligero (respetando privacidad) en el sitio para ver páginas más visitadas; o un canal sencillo de feedback (mailto o formulario) para sugerencias.

---

## 4. Priorización sugerida (orden de impacto / esfuerzo)

| Prioridad | Área | Mejora | Esfuerzo |
|-----------|------|--------|----------|
| Alta | Web | Meta descripción y títulos por página (SEO) | Bajo |
| Alta | Proyecto | Revisar enlaces a demos cada X meses (mantenimiento) | Bajo |
| Media | Web | Revisar contraste y legibilidad (accesibilidad) | Bajo |
| Media | Aplicativos | Mensaje de carga o spinner en demos que tardan | Bajo–medio |
| Media | Proyecto | README por repo con "cómo correr en local" y enlace al sitio | Bajo |
| Baja | Web | Imágenes en WebP / optimización | Medio |
| Baja | Proyecto | ESTADO_PROYECTO.md o sección en README | Bajo |
| Baja | Proyecto | Analytics o feedback opcional | Medio |

---

*Documento vivo: conviene revisarlo y actualizarlo cuando cambien prioridades o se implementen mejoras.*
