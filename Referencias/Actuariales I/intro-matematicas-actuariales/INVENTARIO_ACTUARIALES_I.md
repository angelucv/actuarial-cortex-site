# Inventario detallado — Fuentes para el libro Matemáticas Actuariales I

Este documento resume el contenido de las fuentes locales usadas para el vaciado en el libro *Introducción a las Matemáticas Actuariales*.

---

## 1. Guía docente: `GuiaAct1_27-01-2017.pdf`

**Ubicación:** `Referencias/Actuariales I/GuiaAct1_27-01-2017.pdf`  
**Extracto de texto:** `Referencias/Actuariales I/GuiaAct1_27-01-2017_extracto.txt` (40 páginas).

**Autores (guía):** Prof. Felipe Moreno Colmenares, Prof. Genesis Briceño, Prof. Angel Colmenares (Caracas, 2017).  
**Base teórica:** Libro de contingencias de vida de la SOA y Prof. Chester Wallace Jordan, Jr. (2.ª ed., 1982); marco conceptual: modelos determinísticos de contingencias de vida (Promislow, 2015).

### Estructura de la guía

| Páginas | Sección | Contenido resumido |
|--------|---------|--------------------|
| 1 | Portada | UCV, EECA, Departamento de Actuariado, Código 4605, autores, 2017 |
| 2–6 | **1. Introducción** | Historia: ley romana, Ulpiano; Pascal/Fermat (1654); Graunt (1662), Huygens (vida media); Halley (tablas estacionarias); Dodson (prima por edad, prima nivelada, reserva, tasa técnica), Equitable Life 1762, Mores (título “actuario”); notación: Baily, Milne, Gompertz (Lx), Davies (D, N, S), Morgan (sufijo x), Jones (p, a, A); siglo XX: seguros no-vida, Bühlmann (credibilidad); Jordan, modelos determinísticos vs. estocásticos; cita Cicerón; agradecimientos |
| 7–9 | **2.1 Dotales puros** | Valor presente $K\,{}_np_x\,v^n$; $nE_x = A_{x:\overline{1}|}^{\,\,1}= {}_np_x\,v^n = v^n l_{x+n}/l_x$; $D_x = v^x l_x$; $nE_x = D_{x+n}/D_x$; funciones conmutativas; PPU dotal puro; ejemplo CSO58, 35 años, 20 años, 1000 USD, 3%; interpretación fondo y sobrevivientes |
| 9–14 | **2.2 Rentas de vida con pagos anuales** | $a_x$, $a_{x:\overline{n}|}$, $n|a_x$, $n|a_{x:\overline{m}|}$; $N_x = \sum_{t\ge 0} D_{x+t}$; fórmulas (2.2)–(2.5); rentas anticipadas $\ddot{a}_x$, $\ddot{a}_{x:\overline{n}|}$, $n|\ddot{a}_x$, $n|\ddot{a}_{x:\overline{m}|}$ (2.6)–(2.9); relaciones vencida/anticipada (2.10)–(2.13); fracción inicial $_{1/k}|\ddot{a}_x$; renta acumulada $s_{x:\overline{n}|}$, $\ddot{s}_{x:\overline{n}|}$ (2.14)–(2.15); fórmula general (2.16) $N_y - N_{y+n}$ sobre $D_x$; tablas selectas |
| 15–18 | **2.3 Rentas pagaderas m veces al año** | $a_x^{(m)}$; Woolhouse; $dD_x/dx = -D_x(\mu_x+\delta)$; aproximaciones (2.18)–(2.24); expresiones en D, N |
| 18–20 | **2.4 Rentas continuas** | $\bar{a}_x = \lim_{m\to\infty} a_x^{(m)}$; integrales; $\bar{N}_x$, $\bar{D}_x$; (2.25)–(2.33); derivadas (2.34)–(2.37) |
| 21–25 | **2.5 Rentas variables** | Combinaciones de rentas niveladas; $(Ia)_x$, $(Ia)_{x:\overline{n}|}$, $(I\overline{a})_x$; $S_x$; (Ia), (Da), anticipadas; pagos m veces al año; (Īā)_x; (2.38)–(2.47) |
| 26–28 | **2.6 Efectos de variación en interés y mortalidad** | $da_x/di$, sensibilidad; (2.50) |
| 28–29 | **2.7 Resumen de notación** | Tabla resumen notación rentas |
| 30–32 | **3.1–3.2 Seguros de vida** | Introducción; seguros pagables al fin del año de la muerte: $A_x$, $A_{x:\overline{n}|}^1$, $A_{x:\overline{n}|}$, $A_{x:\overline{n}|}^{\,\,1}$; fórmulas en $C_x$, $M_x$, $D_x$; conmutativas |
| 32–35 | **3.3–3.4 Relación seguros–rentas; seguros al momento de la muerte** | Relación (3.12) $1 = i\,a_x + (1+i)A_x$; seguros continuos $\bar{A}_x$, integrales; $\bar{A}_{x:\overline{n}|}^1$ |
| 36–39 | **3.5–3.6 Seguros variables; resumen notación** | Seguros variables; tabla resumen notación seguros |
| 40 | — | Cierre / referencias |

### Fórmulas y notación clave (guía)

- **Conmutativas:** $D_x = v^x l_x$, $N_x = \sum_{t\ge 0} D_{x+t}$, $nE_x = D_{x+n}/D_x$.
- **Rentas vencidas:** $a_x = N_{x+1}/D_x$, $a_{x:\overline{n}|} = (N_{x+1}-N_{x+n+1})/D_x$, $n|a_x = N_{x+n+1}/D_x$.
- **Rentas anticipadas:** $\ddot{a}_x = N_x/D_x$, $\ddot{a}_{x:\overline{n}|} = (N_x - N_{x+n})/D_x$.
- **Forma general (2.16):** $(N_y - N_{y+n})/D_x$ (y = edad primer pago, n = número de pagos, x = edad contratación).

---

## 2. Carpeta: Matemáticas Actuariales I PL II-2024 (Documentos)

**Ubicación:** `Referencias/Actuariales I/Matemáticas Actuariales I PL II-2024 (Documentos)/`

Estructura por **Semanas 1–15**. Cada semana puede contener:

- **Clase XX:** Presentaciones/clases (PDF) con nombre tipo `MatActI - 2024 PLE I - Clase YYYY_MM_DD - Tema.pdf`.
- **Mat_Act_I - NN - ...:** Material base (PDF) con numeración y descripción del tema.
- **Videos Semana N:** Archivos de video (.avi, .mkv) de clases.
- **Práctica / Parciales:** Prácticas y exámenes por período.

### Resumen por semana (PDFs y temas indicados por nombre)

- **Semana 1:** Conmutativos (Vzlna Hombres), Rentas anuales ciertas PPU, Dotal puro PPU, Rentas fraccionadas ciertas PPU, PPU rentas pagaderas m veces al año (y continuas/variables), Tema 1.
- **Semana 2:** Rentas fraccionadas variables por fracción, Rentas variables anualmente, PPU rentas m veces/continuas/variables; Rentas pagaderas en forma continua; videos.
- **Semana 3:** PPU Seguro por fallecimiento monto variable; PPU Seg por fallecimiento renta post mortem y más; videos.
- **Semana 4:** Práctica.
- **Semana 5:** Práctica; Parcial 1 (2023 PLE II).
- **Semana 6:** Práctica; Parcial 1 (2021, 2022 PLE I).
- **Semana 7:** Reservas matemáticas – Introducción, Prospectivo.
- **Semana 8:** Reservas matemáticas – Prospectivo, Retrospectivo (varias clases).
- **Semana 9:** Reservas matemáticas – Varios; Reserva de balance.
- **Semana 10:** Reservas – Primas fracc.; Primas de ahorro y riesgo; simulaciones y ejercicios (ResMat Prosp/Retrosp/Recurrente, PrimaRiesgo).
- **Semana 11:** Práctica.
- **Semana 12:** Práctica 2.º Parcial (2023 PLE I/II).
- **Semana 13:** Primas comerciales; Modif. reservas terminales – valor de rescate; normas regl. actuariales (Gaceta); Provisión bonos/comisiones (Gaceta).
- **Semana 14:** Desgravamen hipotecario, tópicos especiales; Cálculos prima comercial.
- **Semana 15:** Prácticas 3.er Parcial (2019 I, 2023 I/II).

(En la carpeta hay además numerosos PDFs de ejercicios concretos con letras k, l, m, n, o, p para reservas y primas de riesgo.)

---

## 3. Mapeo sugerido Guía → Capítulos del libro

**Parte I** se basa en el enfoque estándar de Jordan (1982) y Bowers et al. (1997): modelo de supervivencia, fuerza de mortalidad, tablas de mortalidad, probabilidades y expectativas (capítulos 01 a 04). No proviene de la Guía 2017 (que empieza con dotales/rentas); da la base para la Parte II.

| Contenido GuiaAct1 | Capítulo libro |
|--------------------|----------------|
| 1. Introducción (historia, Jordan, Dodson, notación) | `00-preliminares.qmd` |
| 2.1 Dotales puros, $D_x$, $N_x$, $nE_x$ | `05-valor-presente-actuarial.qmd` (y/o capítulo de rentas) |
| 2.2 Rentas anuales (vencidas/anticipadas, temporales, diferidas) | `07-anualidades-contingentes.qmd` |
| 2.3 Rentas pagaderas m veces al año | `07-anualidades-contingentes.qmd` |
| 2.4 Rentas continuas | `08-seguros-anualidades-continuos.qmd` o `07` |
| 2.5 Rentas variables | `07-anualidades-contingentes.qmd` |
| 2.6 Efectos variación i y mortalidad | `07` o recuadro en `05` |
| 2.7 Resumen notación rentas | `apendice-glosario-notaciones.qmd` |
| 3. Seguros de vida (fin año, momento muerte, variables) | `06-seguros-vida.qmd`, `08-seguros-anualidades-continuos.qmd` |
| Primas y reservas (PL II-2024 Sem 7–14) | `09` a `12` |

---

## 4. Próximos pasos para el vaciado

1. ~~**00-preliminares:** Introducción completa de la guía.~~ Hecho.
2. ~~**05-valor-presente-actuarial:** 2.1 Dotales puros, $D_x$, $N_x$, $nE_x$, ejemplo CSO58.~~ Hecho.
3. ~~**07-anualidades-contingentes:** 2.2–2.5 (rentas anuales, fraccionadas, continuas, variables), 2.6 (efectos), 2.7 (resumen notación).~~ Hecho.
4. ~~**06-seguros-vida y 08-seguros-anualidades-continuos:** Cap. 3 de la guía (seguros fin de año, relación seguros–rentas, momento de muerte, variables, resumen).~~ Hecho; redactado como capítulos de libro con narrativa y transiciones.
5. ~~**09–12:** A partir de Jordan y PL II-2024 Semanas 7–14 (primas neta única, periódicas, reserva prospectiva/retrospectiva/recurrente, reservas fraccionarias).~~ Hecho.
6. ~~**Parte IV (13–14):** Extensiones (primas comerciales, valor de rescate, normativa, desgravamen, tablas selectas, múltiples vidas, múltiple decremento, modelos estocásticos) y Resumen y perspectivas (resumen por partes, aplicaciones, perspectivas MA II, CVEA/EECA).~~ Hecho; vaciado extenso.
7. Revisar **PL II-2024** por semana para extraer ejercicios o ejemplos concretos de los PDFs cuando se necesiten.

---

*Inventario generado para el proyecto CVEA. Fuentes: GuiaAct1_27-01-2017.pdf y carpeta Matemáticas Actuariales I PL II-2024 (Documentos).*
