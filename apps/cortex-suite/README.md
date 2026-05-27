# Cortex Suite — Demos interactivos (Streamlit)

App de **Actuarial Cortex** ejecutable desde `actuarial-cortex-site`.  
Demos por sector: **Bank**, **Insurance**, **Retail**, **Health**, **Control**. Datos simulados.

## Ejecución local

Desde la raíz del sitio (`actuarial-cortex-site`):

```bash
cd apps/cortex-suite
pip install -r requirements.txt
streamlit run Home.py
```

O desde la raíz del repo (si estás en `actuarial-cortex-site`):

```bash
streamlit run apps/cortex-suite/Home.py
```

En el navegador se abrirá la app; use el menú lateral para ir a cada demo (1. Bank Suite … 5. Control Suite).

## Despliegue en Streamlit Community Cloud

1. Entra en **[share.streamlit.io](https://share.streamlit.io)** e inicia sesión con GitHub.
2. Clic en **「New app」**.
3. **Repository:** `angelucv/actuarial-cortex-site`
4. **Branch:** `main`
5. **Main file path:** `apps/cortex-suite/Home.py` (usar barras `/`).
6. **App URL:** puedes dejar la que asigne Streamlit (ej. `cortex-suite-home-xxxx.streamlit.app`) o configurar un subdominio si lo tienes.
7. Clic en **「Deploy」**. Streamlit clonará el repo, instalará las dependencias de `apps/cortex-suite/requirements.txt` y ejecutará la app desde la raíz del repo (los logos en `logo-AC/` se cargarán correctamente).

## Logos

La app busca los logos en la raíz del repo (`logo-AC/`), solo variantes **Actuarial Cortex** (sin logos personales):

- Home (fondo claro): `logo-actuarial-cortex-principal-negro.png`
- Sidebar (fondo oscuro): `logo-actuarial-cortex-vertical-blanco.png`
- Cabecera de cada demo: `logo-actuarial-cortex-vertical-negro.png`

Si `logo-AC` no existe, la app sigue funcionando y muestra el título en lugar de las imágenes.
