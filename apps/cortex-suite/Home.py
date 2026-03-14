import streamlit as st
from pathlib import Path
from theme import apply_cvea_theme, LOGO_MAIN_STR, LOGO_SIDEBAR_STR, CORTEX_SITE_URL, render_sidebar_footer

st.set_page_config(
    page_title="Cortex Suite Demos",
    page_icon="📊",
    layout="wide",
    initial_sidebar_state="expanded",
)

apply_cvea_theme()

if LOGO_SIDEBAR_STR:
    st.sidebar.image(LOGO_SIDEBAR_STR)
st.sidebar.markdown(f"[**Ir a Actuarial Cortex**]({CORTEX_SITE_URL})")
render_sidebar_footer()

st.markdown("<div class='cvea-topbar'>Cortex Suite — Demos interactivos</div>", unsafe_allow_html=True)
st.markdown(f"<a href='{CORTEX_SITE_URL}' class='cvea-back'>← Ir a Actuarial Cortex</a>", unsafe_allow_html=True)

if LOGO_MAIN_STR and Path(LOGO_MAIN_STR).exists():
    st.image(LOGO_MAIN_STR)
else:
    st.markdown("## Cortex Suite — Actuarial Cortex")

st.markdown(f"""
**[Actuarial Cortex]({CORTEX_SITE_URL})** es un hub de conocimiento y tecnología actuarial. **Cortex Suite** es un conjunto de demos interactivos por sector (banca, seguros, retail, salud, control) que muestran analítica, cuadros de mando y modelos con datos simulados. Todas las funcionalidades son **adaptables** a las necesidades y procesos específicos de cada organización.

*Todos los demos utilizan **datos simulados o de demostración** con fines ilustrativos.*
""")

st.subheader("Demos por sector")
st.markdown("""
Use el **menú lateral** para navegar a cada demo:

| Demo | Descripción |
|------|-------------|
| **1. Bank Suite** | Credit & Market Risk (NIIF 9), liquidez, visión 360 de la cartera y tesorería. |
| **2. Insurance Suite** | Reservas técnicas, siniestralidad por ramo, monitoreo de reservas y análisis por productos. |
| **3. Retail Suite** | POS, participación de mercado, elasticidad de precios, reglas de asociación, PyGWalker. |
| **4. Health Suite** | Morbilidad, auditoría clínica vs baremos, Monte Carlo de reservas de salud, tarificación. |
| **5. Control Suite** | Flotas, OEE, mantenimiento predictivo, cascada de gastos, análisis exploratorio. |
""")
