# Propuesta: Cortex Suite unificado (una sola página)

Una sola página **Cortex Suite** que reemplaza Actuarial Suite y la antigua Cortex Suite. Estructura por secciones tal como se vería en el sitio.

---

## Título y barra de acceso rápido

- **Título:** Cortex Suite  
- **Subtítulo:** Aplicativos, demos y soluciones por sector  
- **Barra de botones (arriba):**  
  [Demos por sector] [Dashboard SUDEASEG] [Tarificación telemática] [Gestión Social] [Detección de Fraude]

---

## Sección 1 — Seguros

**Encabezado:** Seguros

Dos demos en esta sección:

| Demo | Descripción breve | Enlace |
|------|-------------------|--------|
| **Dashboard Actividad Aseguradora (Insurdata)** | Inteligencia de datos del sector asegurador venezolano (SUDEASEG): primas, siniestros, análisis por empresa y ramo. Streamlit + Supabase. | [Abrir Dashboard Actividad Aseguradora](https://insurdata-dashboard.streamlit.app/) |
| **Tarificación telemática** | Demo Shiny (R): uso de variables telemáticas para frecuencia y severidad, segmentación de riesgo y tarificación en seguros auto. | [Abrir Tarificación telemática](https://7rho5x-profesor-angel.shinyapps.io/ActuarialTelematicsV2/) |

Texto opcional: una línea tipo “Datos regulatorios y modelos de tarificación para el sector asegurador.”

---

## Sección 2 — Banca

**Encabezado:** Banca

Un demo:

| Demo | Descripción breve | Enlace |
|------|-------------------|--------|
| **Detección de Fraude** | Análisis de fraude en transacciones: IER, tasa de fraude, segmentación por marca de tarjeta o categoría de comercio. Streamlit. | [Abrir Detección de Fraude](https://angelucv-actuarial-cortex-bank-fraud.hf.space) |

Texto opcional: una línea tipo “Herramientas de riesgo operativo y fraude para el sector financiero.”

---

## Sección 3 — General (gestión social)

**Encabezado:** Gestión social

Un demo:

| Demo | Descripción breve | Enlace |
|------|-------------------|--------|
| **Gestión Social** | Gestión de solicitudes y ayudas sociales: Admin, dashboard con KPIs, mapa por estados, visión histórica. Django. | [Abrir Gestión Social](https://angelucv-actuarial-cortex-gestion-social.hf.space) |

Texto opcional: una línea tipo “Seguimiento de casos y ejecución de programas sociales.”

---

## Sección 4 — Demos por área (genérico)

**Encabezado:** Demos por área — Banca, Seguros, Retail, Salud, Control

Texto introductorio (el que ya tienes): “El entorno empresarial venezolano… Cortex Suite, un ecosistema tecnológico…” y los tres pilares (Carga y control, Monitoreo y cuadros de mando, Analítica avanzada).

Luego, las **5 subsecciones** actuales (resumen; en la página se mantendría el detalle que ya existe):

1. **Cortex Bank Suite** — liquidez, riesgo de crédito, tesorería.  
   [Abrir Cortex Bank Suite](https://actuarial-cortex-demos.streamlit.app/)

2. **Cortex Insurance Suite** — reservas, siniestralidad, ramos, cumplimiento.  
   [Abrir Cortex Insurance Suite](https://actuarial-cortex-demos.streamlit.app/)  
   (Aquí se puede mencionar que el Dashboard Actividad Aseguradora es el demo destacado de datos regulatorios.)

3. **Cortex Retail Suite** — inteligencia comercial, precios, inventario.  
   [Abrir Cortex Retail Suite](https://actuarial-cortex-demos.streamlit.app/3_Retail_Suite)

4. **Cortex Health Suite** — morbilidad, auditoría clínica, reservas salud.  
   [Abrir Cortex Health Suite](https://actuarial-cortex-demos.streamlit.app/4_Health_Suite)

5. **Cortex Control Suite** — flotas, OEE, cadena de suministro.  
   [Abrir Cortex Control Suite](https://actuarial-cortex-demos.streamlit.app/5_Control_Suite)

Enlace común a la plataforma: [Abrir plataforma de demos (todos los sectores)](https://actuarial-cortex-demos.streamlit.app/)

---

## Sección 5 — Cortex Suite Lab (opcional, al final)

**Encabezado:** Cortex Suite Lab — Otros desarrollos

- Tarificación telemática (ya incluida en Seguros; aquí solo mención + mismo enlace si se desea).
- Prototipo Actuarial Insurtech (Shiny, R): indicadores técnicos, comparación aseguradora vs mercado, simulación de cartera.

---

## Menú del sitio (después de unificar)

- Se elimina la entrada **Actuarial Suite**.
- Una sola entrada: **Cortex Suite** → `cortex-suite.html`.
- En el índice (Inicio): una sola tarjeta “Cortex Suite” que enlaza a esta página unificada.

---

## Resumen visual de la página (orden de lectura)

```
[Cortex Suite — Hero + barra de botones]

1. Seguros
   · Dashboard Actividad Aseguradora (Insurdata)    [Abrir]
   · Tarificación telemática           [Abrir]

2. Banca
   · Detección de Fraude              [Abrir]

3. Gestión social
   · Gestión Social                   [Abrir]

4. Demos por área (genérico)
   · Intro / propuesta de valor
   · Cortex Bank Suite                [Abrir]
   · Cortex Insurance Suite            [Abrir]
   · Cortex Retail Suite               [Abrir]
   · Cortex Health Suite               [Abrir]
   · Cortex Control Suite              [Abrir]
   · [Abrir plataforma de demos]

5. Cortex Suite Lab (otros desarrollos)
   · Telemática (enlace)
   · Actuarial Insurtech (mención)

[Contacto · Miembros]
```

---

## Archivos a tocar

- **Modificar:** `cortex-suite.qmd` — reestructurar con las secciones 1–5 anteriores e integrar contenido de `actuarial-suite.qmd`.
- **Eliminar:** `actuarial-suite.qmd` (o redirigir a `cortex-suite.html` si quieres mantener la URL antigua).
- **Actualizar:** `_website.yml` — quitar ítem “Actuarial Suite”, dejar solo “Cortex Suite”.
- **Actualizar:** `index.qmd` — quitar tarjeta/enlace a Actuarial Suite; una sola tarjeta “Cortex Suite” que apunte a `cortex-suite.html`.

Si esta estructura te encaja, el siguiente paso es aplicar estos cambios en los `.qmd` y en el menú sin compilar hasta que confirmes.
