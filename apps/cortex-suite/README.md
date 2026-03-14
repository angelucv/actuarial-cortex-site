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

## Logos

La app busca los logos de Actuarial Cortex en la raíz del sitio:

- `actuarial-cortex-site/logo-AC/logo-actuarial-cortex-principal-blanco.png`
- `actuarial-cortex-site/logo-AC/logo-ac-blanco.png`

Si la carpeta `logo-AC` no existe, la app funciona igual pero sin mostrar imágenes de logo (se muestra el título "Cortex Suite"). Puedes copiar la carpeta `logo-AC` desde el proyecto Quarto de Actuarial Cortex si la tienes.
