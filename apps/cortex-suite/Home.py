import streamlit as st
from pathlib import Path

from theme import (
    LOGO_HOME_STR,
    apply_cvea_theme,
    render_sidebar_branding,
    render_topbar,
)

st.set_page_config(
    page_title="Cortex Suite Demos",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="expanded",
)

apply_cvea_theme()
render_sidebar_branding()
render_topbar()

if LOGO_HOME_STR and Path(LOGO_HOME_STR).exists():
    st.image(LOGO_HOME_STR, width=420)
else:
    st.markdown("## Cortex Suite")

st.markdown(
    """
**Cortex Suite** es un conjunto de demos interactivos por sector (banca, seguros, retail, salud, control)
que muestran analítica, cuadros de mando y modelos con datos simulados. Todas las funcionalidades son
**adaptables** a las necesidades y procesos específicos de cada organización.

*Todos los demos utilizan **datos simulados o de demostración** con fines ilustrativos.*
"""
)

st.subheader("Demos por sector")
st.markdown(
    """
Use el **menú lateral** para navegar a cada demo:

| Demo | Descripción |
|------|-------------|
| **1. Bank Suite** | Credit & Market Risk (NIIF 9), liquidez, visión 360 de la cartera y tesorería. |
| **2. Insurance Suite** | Reservas técnicas, siniestralidad por ramo, monitoreo de reservas y análisis por productos. |
| **3. Retail Suite** | POS, participación de mercado, elasticidad de precios, reglas de asociación, PyGWalker. |
| **4. Health Suite** | Morbilidad, auditoría clínica vs baremos, Monte Carlo de reservas de salud, tarificación. |
| **5. Control Suite** | Flotas, OEE, mantenimiento predictivo, cascada de gastos, análisis exploratorio. |
"""
)
