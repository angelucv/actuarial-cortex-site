# Cortex Health Suite — Morbilidad, auditoría clínica, reservas, tarificación
import streamlit as st
import pandas as pd
import numpy as np
import plotly.express as px
import plotly.graph_objects as go
from theme import cvea_header

st.set_page_config(page_title="Cortex Health Suite", page_icon="🏥", layout="wide")
cvea_header(
    "Cortex Health Suite",
    "Monitoreo epidemiológico, auditoría clínica, solvencia y tarificación — Datos simulados",
)

@st.cache_data
def get_health_claims(n=22_000):
    rng = np.random.default_rng(111)
    cie10 = [f"E11", "I10", "J00", "K21", "M54", "R50", "Z00", "A09", "N39", "E66"]
    servicios = ["Consulta Triaje", "Ecograma Mamario", "Ecograma Prostático", "Telemedicina", "Consulta Especialista", "Laboratorio"]
    clinicas = [f"Clínica {chr(65+i)}" for i in range(8)]
    dates = pd.date_range("2023-01-01", periods=730, freq="D")
    records = []
    for i in range(n):
        records.append({
            "id_paciente": rng.integers(1, 8000),
            "codigo_CIE10": rng.choice(cie10),
            "tipo_servicio": rng.choice(servicios, p=[0.25, 0.1, 0.08, 0.15, 0.25, 0.17]),
            "clinica_proveedora": rng.choice(clinicas),
            "costo_facturado_usd": np.clip(rng.lognormal(5, 1.2), 20, 3000),
            "limite_baremo_usd": np.clip(rng.lognormal(5, 0.9), 25, 2500),
            "fecha_admision": rng.choice(dates),
        })
    return pd.DataFrame(records)

df_h = get_health_claims()
st.sidebar.header("Controles")
sensibilidad_auditoria = st.sidebar.slider("Sensibilidad de auditoría (umbral revisión)", 0.1, 0.9, 0.5, 0.05)
inflacion_medica = st.sidebar.number_input("Inflación médica (% anual)", 0.0, 100.0, 25.0, 1.0) / 100
inflacion_general = st.sidebar.number_input("Inflación general (% anual)", 0.0, 150.0, 40.0, 5.0) / 100

tab1, tab2, tab3, tab4 = st.tabs(["Monitoreo epidemiológico", "Auditoría clínica", "Solvencia y reservas", "Tarificación y modalidades"])

with tab1:
    st.subheader("KPIs")
    admisiones_mes = len(df_h) / 24
    tasa_adm = admisiones_mes / 8000 * 100
    ent = len(df_h[df_h["codigo_CIE10"].str.startswith("E") | df_h["codigo_CIE10"].str.startswith("I")]) / len(df_h) * 100
    tele = len(df_h[df_h["tipo_servicio"] == "Telemedicina"]) / len(df_h) * 100
    c1, c2, c3 = st.columns(3)
    c1.metric("Tasa de admisión mensual (sim.)", f"{tasa_adm:.2f}%", "—")
    c2.metric("Prevalencia ENT (sim.)", f"{ent:.1f}%", "—")
    c3.metric("Uso telemedicina vs presencial", f"{tele:.1f}% telemedicina", "—")
    st.subheader("Volumen de siniestros por tipo de servicio y clínica")
    agg = df_h.groupby(["tipo_servicio", "clinica_proveedora"]).size().unstack(fill_value=0)
    fig_map = px.imshow(agg, text_auto=True, aspect="auto", color_continuous_scale="Blues")
    st.plotly_chart(fig_map)

with tab2:
    st.subheader("Costo por procedimiento vs baremo")
    fig_violin = px.violin(df_h, x="tipo_servicio", y="costo_facturado_usd", box=True, points="outliers")
    st.plotly_chart(fig_violin)
    df_h["fecha"] = pd.to_datetime(df_h["fecha_admision"]).dt.date
    daily = df_h.groupby("fecha")["costo_facturado_usd"].mean().reset_index()
    daily["fecha"] = pd.to_datetime(daily["fecha"])
    media = daily["costo_facturado_usd"].mean()
    std = daily["costo_facturado_usd"].std() or 1
    daily["LSC"] = media + 2 * std
    daily["LIC"] = media - 2 * std
    fig_control = go.Figure()
    fig_control.add_trace(go.Scatter(x=daily["fecha"], y=daily["costo_facturado_usd"], name="Costo promedio diario"))
    fig_control.add_trace(go.Scatter(x=daily["fecha"], y=daily["LSC"], line=dict(dash="dash", color="red"), name="LSC"))
    fig_control.add_trace(go.Scatter(x=daily["fecha"], y=daily["LIC"], line=dict(dash="dash", color="red"), name="LIC"))
    fig_control.update_layout(title="Gráfico de control (Shewhart) — Costo promedio por admisión", height=350)
    st.plotly_chart(fig_control)
    from sklearn.ensemble import IsolationForest
    X = df_h[["costo_facturado_usd", "limite_baremo_usd"]].copy()
    X["ratio"] = X["costo_facturado_usd"] / (X["limite_baremo_usd"] + 1)
    iso = IsolationForest(contamination=sensibilidad_auditoria, random_state=42)
    df_h["_outlier"] = iso.fit_predict(X)
    df_audit = df_h[df_h["_outlier"] == -1][["id_paciente", "tipo_servicio", "clinica_proveedora", "costo_facturado_usd", "limite_baremo_usd"]].head(200)
    st.subheader("Facturas sugeridas para revisión (desviaciones)")
    st.dataframe(df_audit)

with tab3:
    st.subheader("Simulación Monte Carlo — Patrimonio del fondo a 5 años (Teoría de la ruina)")
    np.random.seed(222)
    años, paths = 5, 100
    patrimonio_inicial, ingresos_anuales, gastos_base = 5_000_000, 3_200_000, 2_800_000
    proy = np.zeros((paths, años + 1))
    proy[:, 0] = patrimonio_inicial
    for t in range(1, años + 1):
        infl = (1 + inflacion_medica) ** t
        gastos = gastos_base * infl * (1 + np.random.randn(paths) * 0.1)
        proy[:, t] = proy[:, t - 1] + ingresos_anuales - gastos
    proy = np.maximum(proy, 0)
    fig_ruina = go.Figure()
    for i in range(min(20, paths)):
        fig_ruina.add_trace(go.Scatter(x=list(range(años + 1)), y=proy[i], mode="lines", line=dict(width=1, color="lightblue"), showlegend=False))
    fig_ruina.add_trace(go.Scatter(x=list(range(años + 1)), y=proy.mean(axis=0), mode="lines", line=dict(width=3, color="darkblue"), name="Media"))
    fig_ruina.update_layout(xaxis_title="Año", yaxis_title="Patrimonio (USD)", title="Proyección patrimonio (inflación médica aplicada)", height=400)
    st.plotly_chart(fig_ruina)

with tab4:
    st.subheader("Rentabilidad por modalidad (embudo)")
    modalidades = ["Tradicional", "Asistencia domiciliaria", "Telemedicina"]
    siniestralidad = [0.72, 0.68, 0.55]
    fig_funnel = px.funnel(x=siniestralidad, y=modalidades, title="Siniestralidad por modalidad")
    st.plotly_chart(fig_funnel)
    st.subheader("Simulador de primas (coaseguro, deducible, tope)")
    coaseguro = st.number_input("Coaseguro (%)", 0, 50, 20)
    deducible = st.number_input("Deducible (USD)", 0, 500, 100)
    tope = st.number_input("Tope de cobertura (USD)", 1000, 50000, 10000)
    prima_base = 80
    prima_ajustada = prima_base * (1 - coaseguro / 100) * (1 + deducible / 1000) * (tope / 10000) ** 0.1
    margen_suf = (prima_ajustada - 60) / prima_ajustada if prima_ajustada > 0 else 0
    st.metric("Prima resultante (USD/mes)", f"{prima_ajustada:.2f}", "—")
    if margen_suf >= 0.15:
        st.success("Margen de suficiencia actuarial cumplido (≥15%).")
    else:
        st.warning("Margen por debajo del 15% — revisar tarifa para viabilidad del plan.")
