# Changelog

Registro de cambios relevantes del portal web y aplicativos de Actuarial Cortex. Formato inspirado en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/).

---

## [Sin publicar]

_(Próximos cambios.)_

---

## [2026-03]

### Añadido
- URL canónica en `og-meta.html` para SEO.
- `robots.txt` con `Sitemap` apuntando a `sitemap.xml` (Quarto genera el sitemap al construir con `site-url`).
- Endpoint de salud `/health/` en la app Gestión Social (Django) para monitoreo.
- Mensaje de error amigable en el demo de Detección de Fraude (Streamlit) si falla la carga de datos, con enlace a Actuarial Cortex.
- Imágenes WebP para logos principales (`logo-ac-blanco.webp`, `logo-AC-AC-vertical-horizontal-blanco.webp`) y uso de `<picture>` en Inicio, Cortex Suite y Actuarial Suite para priorizar WebP con fallback PNG.

### Cambiado
- Tabla "Demos desplegados" en Cortex Suite con ancho limitado y scroll horizontal en móvil.
- Eliminadas referencias públicas a documentos internos del repositorio (mapa de aplicativos, etc.) en la web y en el README.

---

## Histórico

Entradas anteriores (ej. integración Cortex Suite unificado, textos de introducción consistentes, lazy loading en imágenes, meta OG y aria-labels en navbar) pueden documentarse aquí con fecha.
