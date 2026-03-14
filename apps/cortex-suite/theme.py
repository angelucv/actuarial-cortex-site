"""
Tema Cortex Suite — Actuarial Cortex.
Ejecución desde actuarial-cortex-site/apps/cortex-suite → ROOT = actuarial-cortex-site.
Logos en ROOT/logo-AC/; si no existen, la app no muestra imagen (evita fallo).
"""
import streamlit as st
from pathlib import Path

# Raíz del sitio (actuarial-cortex-site) cuando se ejecuta desde apps/cortex-suite
ROOT = Path(__file__).resolve().parents[2]

# Logos Actuarial Cortex (carpeta logo-AC en la raíz del sitio)
# Fondo blanco → logo negro (vertical-horizontal); sidebar oscuro → logo blanco (vertical)
def _logo(path: Path) -> str:
    return str(path) if path.exists() else ""

# Logo principal (área de contenido, fondo blanco): vertical-horizontal negro
LOGO_MAIN = ROOT / "logo-AC" / "logo-AC-AC-vertical-horizontal-negro.png"
# Logo en cabecera de subpáginas (mismo fondo blanco)
LOGO_HEADER = ROOT / "logo-AC" / "logo-AC-AC-vertical-horizontal-negro.png"
# Logo en menú lateral (sidebar oscuro): vertical blanco
LOGO_SIDEBAR = ROOT / "logo-AC" / "logo-AC-AC-vertical-blanco.png"

LOGO_MAIN_STR = _logo(LOGO_MAIN)
LOGO_HEADER_STR = _logo(LOGO_HEADER)
LOGO_SIDEBAR_STR = _logo(LOGO_SIDEBAR)

CORTEX_PRIMARY = "#38666A"
CORTEX_DARK = "#1e3d40"
CORTEX_LIGHT = "#f5f5f5"


def apply_cvea_theme() -> None:
    """Inyecta estilos con la paleta Cortex Suite (verde/teal) y texto oscuro."""
    st.markdown(
        f"""
<style>
:root {{
  --cvea-primary: {CORTEX_PRIMARY};
  --cvea-dark: {CORTEX_DARK};
  --cvea-light: {CORTEX_LIGHT};
}}

body, .stApp {{
  background-color: white;
  color: #111111;
}}

.block-container, .block-container * {{
  color: #111111 !important;
}}

.block-container a, .block-container .stMarkdown a {{
  color: var(--cvea-primary) !important;
}}

.stSidebar, .stSidebar * {{
  color: white !important;
}}

.stButton>button {{
  background-color: var(--cvea-primary);
  color: white;
  border-radius: 6px;
  border: none;
  padding: 0.4rem 0.9rem;
}}

.stButton>button:hover {{
  background-color: {CORTEX_DARK};
}}

.stMetric-label {{
  color: var(--cvea-dark) !important;
  font-weight: 600;
}}

.cvea-header-title {{
  font-size: 1.6rem;
  font-weight: 700;
  color: var(--cvea-dark) !important;
  margin-bottom: 0.15rem;
}}

.cvea-header-subtitle {{
  font-size: 0.95rem;
  color: #444444 !important;
}}

.cvea-topbar {{
  background-color: #000000;
  color: white !important;
  padding: 0.35rem 0.9rem;
  font-weight: 600;
  font-size: 0.9rem;
  margin-bottom: 0.5rem;
}}

.cvea-back {{
  display: inline-block;
  margin-bottom: 0.5rem;
  padding: 0.25rem 0.75rem;
  background-color: #38666A;
  color: #ffffff !important;
  border-radius: 4px;
  text-decoration: none;
  font-size: 0.85rem;
}}

.stTabs [role="tablist"] {{
  gap: 0.5rem;
}}

.stTabs [role="tab"] {{
  border-radius: 999px;
  padding: 0.3rem 0.9rem;
  border: 1px solid #cccccc;
  background-color: #f3f3f3;
  color: #000000 !important;
  font-weight: 500;
  border-bottom: none !important;
  box-shadow: none !important;
}}

.stTabs [role="tab"][aria-selected="true"] {{
  background-color: {CORTEX_PRIMARY};
  color: #ffffff !important;
  border-color: {CORTEX_PRIMARY};
  border-bottom: none !important;
}}
</style>
""",
        unsafe_allow_html=True,
    )


# URL del sitio Actuarial Cortex (enlace en sidebar y home)
CORTEX_SITE_URL = "https://actuarial-cortex.pages.dev/"


def render_sidebar_footer() -> None:
    """Pie unificado del menú lateral: Prof. Angel Colmenares y Actuarial Cortex."""
    st.sidebar.markdown("---")
    st.sidebar.caption("**Elaborado por el Prof. Angel Colmenares**")
    st.sidebar.caption("© Actuarial Cortex")
    st.sidebar.caption("Conocimiento · Tecnología · Formación")
    st.sidebar.caption("actuarial.cortex@gmail.com | @actuarial_cortex")


def cvea_header(title: str, subtitle: str | None = None) -> None:
    """Cabecera con logo Actuarial Cortex, título y subtítulo (Cortex Suite)."""
    apply_cvea_theme()
    st.markdown("<div class='cvea-topbar'>Cortex Suite — Demos interactivos</div>", unsafe_allow_html=True)
    if LOGO_SIDEBAR_STR:
        st.sidebar.image(LOGO_SIDEBAR_STR)
    st.sidebar.markdown(f"[**Ir a Actuarial Cortex**]({CORTEX_SITE_URL})")
    render_sidebar_footer()
    col_logo, col_text = st.columns([1, 3])
    with col_logo:
        if LOGO_HEADER_STR:
            st.image(LOGO_HEADER_STR)
    with col_text:
        st.markdown(f"<div class='cvea-header-title'>{title}</div>", unsafe_allow_html=True)
        if subtitle:
            st.markdown(f"<div class='cvea-header-subtitle'>{subtitle}</div>", unsafe_allow_html=True)
