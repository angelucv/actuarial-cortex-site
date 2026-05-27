"""
Tema Cortex Suite — Actuarial Cortex.
Ejecución desde actuarial-cortex-site/apps/cortex-suite → ROOT = actuarial-cortex-site.
Logos en ROOT/logo-AC/ (solo marca Actuarial Cortex, sin variantes personales).
"""
import streamlit as st
from pathlib import Path

ROOT = Path(__file__).resolve().parents[2]
LOGO_DIR = ROOT / "logo-AC"


def _logo(path: Path) -> str:
    return str(path) if path.exists() else ""


# Home (fondo claro): principal horizontal negro
LOGO_HOME = LOGO_DIR / "logo-actuarial-cortex-principal-negro.png"
# Sidebar (fondo oscuro): vertical blanco
LOGO_SIDEBAR = LOGO_DIR / "logo-actuarial-cortex-vertical-blanco.png"
# Cabecera de cada demo (fondo claro): vertical negro
LOGO_PAGE = LOGO_DIR / "logo-actuarial-cortex-vertical-negro.png"

LOGO_HOME_STR = _logo(LOGO_HOME)
LOGO_SIDEBAR_STR = _logo(LOGO_SIDEBAR)
LOGO_PAGE_STR = _logo(LOGO_PAGE)

# Compatibilidad con imports antiguos
LOGO_MAIN_STR = LOGO_HOME_STR
LOGO_HEADER_STR = LOGO_PAGE_STR

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


def render_sidebar_branding() -> None:
    """Logo en sidebar y pie mínimo (solo marca Actuarial Cortex)."""
    if LOGO_SIDEBAR_STR:
        st.sidebar.image(LOGO_SIDEBAR_STR, use_container_width=True)
    st.sidebar.markdown("---")
    st.sidebar.caption("© Actuarial Cortex")


def render_topbar() -> None:
    st.markdown(
        "<div class='cvea-topbar'>Cortex Suite — Demos interactivos</div>",
        unsafe_allow_html=True,
    )


def cvea_header(title: str, subtitle: str | None = None) -> None:
    """Cabecera de demo: barra superior, sidebar, logo vertical negro y título."""
    apply_cvea_theme()
    render_topbar()
    render_sidebar_branding()
    col_logo, col_text = st.columns([1, 3])
    with col_logo:
        if LOGO_PAGE_STR:
            st.image(LOGO_PAGE_STR, use_container_width=True)
    with col_text:
        st.markdown(f"<div class='cvea-header-title'>{title}</div>", unsafe_allow_html=True)
        if subtitle:
            st.markdown(
                f"<div class='cvea-header-subtitle'>{subtitle}</div>",
                unsafe_allow_html=True,
            )
