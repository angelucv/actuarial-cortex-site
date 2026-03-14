# Resumen: Aplicativos Actuarial Cortex

**Dónde está este documento (para no perder las rutas):**
- **En este repo:** `docs/ACTUARIAL_CORTEX_APLICATIVOS.md` — [Ver en GitHub](https://github.com/angelucv/actuarial-cortex-site/blob/main/docs/ACTUARIAL_CORTEX_APLICATIVOS.md).
- **En el workspace:** puede existir una copia en `cvea-platform` en la raíz.

Usar esta tabla como **fuente de verdad** para rutas locales, repos y URLs. Actualizarla al añadir aplicativos o cambiar rutas.

---

## Cómo no perder las rutas

1. **Siempre que vayas a tocar un app,** abre este archivo y usa la **ruta completa** de la columna «Carpeta local».
2. **Gestión Social** está **dentro** de la carpeta del sitio pero es un **repo Git aparte** (repo anidado):
   - **Ruta local:** `C:\Users\Angel\actuarial-cortex-site\gestion-social-django`
   - Para commit/push de Gestión Social: `cd` a esa carpeta y ejecutar `git add`, `git commit`, `git push origin main` **desde ahí** (no desde la raíz de `actuarial-cortex-site`). Remotes: `origin` = GitHub (actuarial-cortex-suite-gestion-social), `hf` = Hugging Face.
3. **Cortex Suite (demos)** no tiene repo propio: el código está en `apps/cortex-suite/` de este repo; commit/push desde la raíz de `actuarial-cortex-site`.
4. El resto de apps (Insurdata, Detección de Fraude) tienen cada uno su carpeta y su repo; commit/push desde la carpeta indicada en la tabla.

---

## ¿Unificar repos o dejarlos como están?

**Recomendación: mantener los repos separados** (como están ahora), con una excepción opcional.

| Criterio | Repos separados (actual) | Repo único (monolito) |
|----------|---------------------------|------------------------|
| **Despliegue** | Cada app tiene su pipeline (HF, Streamlit Cloud, etc.) y se despliega sola. | Un solo repo implica un solo origen; los demos que van a HF o Streamlit necesitan rutas distintas y configs por app. |
| **Permisos / colaboración** | Puedes dar acceso por repo (ej. solo Gestión Social). | Todo o nada. |
| **CI/CD** | Workflows por repo, más claros (sync a HF, build del sitio). | Un solo workflow debe distinguir qué carpeta desplegar y dónde. |
| **Tamaño y clonado** | Clonas solo lo que necesitas (ej. sitio web sin los demos). | Repo grande; clones más lentos. |
| **Riesgo** | Un fallo en un app no afecta al resto. | Cambios en una app pueden romper el build global. |

**Conclusión:** La estructura actual (sitio web + varios repos de apps) es adecuada para varios aplicativos con stacks distintos (Quarto, Django, Streamlit, Shiny). Unificar todo en un solo repo añade complejidad de despliegue y de organización sin un beneficio claro, salvo que quieras "un solo lugar donde está todo el código" (en ese caso, un **monorepo** con carpetas bien delimitadas y varios workflows podría funcionar, pero no es necesario).

**Excepción:** Los **demos por sector** (Cortex Suite) ya viven dentro de `actuarial-cortex-site` en `apps/cortex-suite`. Tiene sentido: el sitio es el "hub" y ese demo es ligero y se despliega en Streamlit Cloud desde el mismo repo. No hace falta separarlo.

---

## Mapa de aplicativos: carpeta local, GitHub y web

Todas las rutas locales son completas (Windows) para evitar confusiones. Ajustar según tu usuario (`C:\Users\Angel` → tu `%USERPROFILE%` si aplica).

| Aplicativo | Carpeta local (ruta completa) | Repositorio GitHub | Aplicativo en web |
|------------|-------------------------------|--------------------|-------------------|
| **Sitio web Actuarial Cortex** | `C:\Users\Angel\actuarial-cortex-site` | [angelucv/actuarial-cortex-site](https://github.com/angelucv/actuarial-cortex-site) | [actuarial-cortex.pages.dev](https://actuarial-cortex.pages.dev) (Cloudflare Pages) |
| **Dashboard Actividad Aseguradora (Insurdata)** | `C:\Users\Angel\sudeaseg-dashboard` | [angelucv/insurdata-dashboard](https://github.com/angelucv/insurdata-dashboard) | [insurdata-dashboard.streamlit.app](https://insurdata-dashboard.streamlit.app) (Streamlit Cloud) |
| **Gestión Social** | `C:\Users\Angel\actuarial-cortex-site\gestion-social-django` — o clon aparte: `C:\Users\Angel\actuarial-cortex-suite-gestion-social` | [angelucv/actuarial-cortex-suite-gestion-social](https://github.com/angelucv/actuarial-cortex-suite-gestion-social) | [angelucv-actuarial-cortex-gestion-social.hf.space](https://angelucv-actuarial-cortex-gestion-social.hf.space) (Hugging Face Spaces, Docker) |
| **Detección de Fraude (Banca)** | `C:\Users\Angel\NovaBank_Angel` | [angelucv/actuarial-cortex-demo-bank](https://github.com/angelucv/actuarial-cortex-demo-bank) | [angelucv-actuarial-cortex-bank-fraud.hf.space](https://angelucv-actuarial-cortex-bank-fraud.hf.space) (Hugging Face Spaces) |
| **Demos por sector (Cortex Suite)** | `C:\Users\Angel\actuarial-cortex-site\apps\cortex-suite` | Mismo repo que el sitio: [angelucv/actuarial-cortex-site](https://github.com/angelucv/actuarial-cortex-site) (rama `main`, ruta `apps/cortex-suite/`) | [actuarial-cortex-demos.streamlit.app](https://actuarial-cortex-demos.streamlit.app) (Streamlit Cloud) |
| **Tarificación telemática** | `C:\Users\Angel\...` (ruta del proyecto R/Shiny; completar según tu instalación) | (según tengas el código en GitHub) | [7rho5x-profesor-angel.shinyapps.io/ActuarialTelematicsV2](https://7rho5x-profesor-angel.shinyapps.io/ActuarialTelematicsV2/) (Shinyapps.io) |

---

## Resumen por tipo de despliegue

| Plataforma | Aplicativos |
|------------|-------------|
| **Cloudflare Pages** | Sitio web Actuarial Cortex (Quarto). |
| **Streamlit Cloud** | Dashboard Actividad Aseguradora (Insurdata), Demos por sector (Cortex Suite). |
| **Hugging Face Spaces** | Gestión Social (Docker), Detección de Fraude (Banca). |
| **Shinyapps.io** | Tarificación telemática (Shiny/R). |

---

## Notas

- **Gestión Social:** Ruta local: `C:\Users\Angel\actuarial-cortex-site\gestion-social-django`. Es un **repo Git anidado** (tiene su propio `.git`); los commits se hacen desde esa carpeta. Remotes: `origin` → GitHub (actuarial-cortex-suite-gestion-social), `hf` → Hugging Face.
- **Demos Cortex Suite:** Código en `apps/cortex-suite/` de este repo. "Main file path" en Streamlit Cloud: `apps/cortex-suite/Home.py`. Commit/push desde la raíz del sitio.
- Actualizar la tabla y las rutas si añades aplicativos, cambias URLs o usas otra unidad/carpeta (p. ej. `D:\`).

---

## Recomendaciones de enlaces (consistencia en el sitio)

- **Internos (mismo sitio):** Usar siempre extensión `.html` (p. ej. `cortex-suite.html`, `resources/index.html`). Las páginas en subcarpetas usan `../` para volver a la raíz (p. ej. `../contacto.html`).
- **Externos (demos, GitHub):** Usar URL completa y `target="_blank"` y `rel="noopener noreferrer"` en HTML para abrir en nueva pestaña de forma segura.
- **Un solo punto de entrada a demos:** Todos los enlaces a aplicativos desplegados (Insurdata, Gestión Social, Detección de Fraude, Demos por sector, Tarificación telemática) están concentrados en **Cortex Suite** (barra de botones + tabla). El inicio solo muestra Cortex Suite y el tile del Dashboard Actividad Aseguradora; el resto se alcanza desde Cortex Suite para no duplicar URLs.
- **Mapa de aplicativos:** Enlazar desde la web al documento en GitHub (`.../blob/main/docs/ACTUARIAL_CORTEX_APLICATIVOS.md`) para que visitantes y desarrolladores tengan la tabla de rutas y repos en un solo lugar.
