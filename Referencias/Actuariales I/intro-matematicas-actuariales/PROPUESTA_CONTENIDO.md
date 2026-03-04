# Propuesta general de contenido — Introducción a las Matemáticas Actuariales

## Fuente de materiales

El contenido base del libro proviene del curso **Matemáticas Actuariales I**, período lectivo II-2024, organizado por **semanas** en Google Drive:

- **Enlace:** [Matemáticas Actuariales I PL II-2024 (Documentos)](https://drive.google.com/drive/folders/1eD-0wb4dxDdgBI6reOzznviNyEVxHLym?usp=sharing)
- **Estructura en Drive:** carpetas **Semana 1** a **Semana 15** (15 semanas de material).

Este documento propone una estructura de libro (partes y capítulos) alineada con esa organización semanal y con los programas típicos de Matemáticas Actuariales I en la EECA-UCV, para que el contenido descargado o copiado del Drive pueda integrarse de forma ordenada.

---

## Criterios de estructura

1. **Plantilla:** Se usa la misma plantilla que el libro *Introducción a las Matemáticas Financieras* (Quarto, estilo Krantz, partes y capítulos).
2. **Prerrequisito:** Se asume que el lector ha cursado o tiene a mano *Introducción a las Matemáticas Financieras* (interés compuesto, rentas ciertas, ecuaciones de valor, notación $v$, $a_{\overline{n}|}$, etc.).
3. **Enfoque:** Matemáticas actuariales I clásica: modelo de supervivencia, seguros y anualidades contingentes, primas netas y reservas. Las extensiones (múltiples vidas, múltiple decremento) se dejan para un posible segundo volumen o capítulos finales según el material del Drive.

---

## Propuesta de partes y capítulos (mapeo sugerido a 15 semanas)

### Parte I — Fundamentos: supervivencia y tablas de mortalidad  
*Corresponde aproximadamente a Semana 1–4*

| Capítulo | Tema sugerido | Semanas |
|----------|----------------|---------|
| 0 | Preliminares / repaso de interés y notación actuarial | 1 |
| 1 | Modelo de supervivencia: tiempo futuro de vida, función de supervivencia $S(x)$, $F(x)$ | 1–2 |
| 2 | Fuerza de mortalidad $\mu_x$, ley de mortalidad, relación con $S(x)$ | 2 |
| 3 | Tablas de mortalidad: $l_x$, $d_x$, $q_x$, $p_x$, $L_x$, $T_x$, $e_x$ | 2–3 |
| 4 | Probabilidades y expectativas: $_n p_x$, $_n q_x$, $e_x$, vida curta/complete; interpolación | 3–4 |
| (Práctica) | Ejercicios sobre tablas y expectativas | 4 |

**Nota:** Si en el Drive la Semana 1 incluye solo presentación del curso y repaso, el Cap. 0 puede ser breve y el Cap. 1 empezar en Semana 2.

---

### Parte II — Seguros y anualidades contingentes  
*Corresponde aproximadamente a Semana 5–9*

| Capítulo | Tema sugerido | Semanas |
|----------|----------------|---------|
| 5 | Valor presente actuarial (APV): definición, principio del valor presente | 5 |
| 6 | Seguros de vida: temporal, vitalicio, dotal; pagos al fin del año de fallecimiento | 5–6 |
| 7 | Anualidades contingentes: vitalicias, temporales, diferidas; pagos vencidos y anticipados | 6–7 |
| 8 | Seguros y anualidades con pagos al momento de muerte (continuos); relación con discreto | 7–8 |
| (Práctica) | Ejercicios de seguros y anualidades contingentes | 8–9 |

---

### Parte III — Primas y reservas  
*Corresponde aproximadamente a Semana 10–13*

| Capítulo | Tema sugerido | Semanas |
|----------|----------------|---------|
| 9 | Prima neta única (PNU); equivalencia y principio de equivalencia | 10 |
| 10 | Primas periódicas netas: niveladas, limitadas; ecuación de equivalencia | 10–11 |
| 11 | Reserva de beneficio: prospectiva y retrospectiva; ecuación de recurrencia | 11–12 |
| 12 | Reservas en momentos fraccionarios; métodos de aproximación | 12–13 |
| (Práctica) | Ejercicios de primas y reservas | 13 |

---

### Parte IV — Extensiones y cierre  
*Corresponde aproximadamente a Semana 14–15*

| Capítulo | Tema sugerido | Semanas |
|----------|----------------|---------|
| 13 | Introducción a múltiples vidas (status conjunto y último superviviente) o introducción a múltiple decremento | 14 |
| 14 | Resumen, aplicaciones y perspectivas (seguros de vida, pensiones, normativa) | 14–15 |
| (Práctica global) | Integración y repaso | 15 |

**Nota:** La asignación real de las Semanas 14–15 dependerá del contenido concreto del Drive (si hay múltiples vidas, múltiple decremento, o solo repaso y evaluación).

---

## Resumen del mapeo Semana → Parte

| Semanas | Parte |
|---------|--------|
| 1–4 | Parte I: Supervivencia y tablas de mortalidad |
| 5–9 | Parte II: Seguros y anualidades contingentes |
| 10–13 | Parte III: Primas y reservas |
| 14–15 | Parte IV: Extensiones y cierre |

---

## Próximos pasos

1. **Descargar o revisar** el contenido de cada carpeta *Semana 1* … *Semana 15* del [Drive](https://drive.google.com/drive/folders/1eD-0wb4dxDdgBI6reOzznviNyEVxHLym?usp=sharing).
2. **Ajustar** esta propuesta si el orden o los temas del curso difieren (p. ej. si seguros van antes que tablas, o si hay más peso en múltiple decremento).
3. **Redactar** cada capítulo en `.qmd` a partir de los documentos de cada semana, manteniendo la notación unificada y las referencias al libro de Financieras cuando se use $v$, $i$, $a_{\overline{n}|}$, etc.
4. **Incluir** ejercicios resueltos y propuestos por bloque, siguiendo el estilo del libro de Financieras.

---

## Estructura de archivos del libro (plantilla)

```
libro/intro-matematicas-actuariales/
├── PROPUESTA_CONTENIDO.md     (este archivo)
├── _quarto.yml
├── index.qmd
├── references.bib
├── frontmatter.tex            (opcional; portada PDF)
├── style/
│   └── krantz.cls
├── assets/
│   └── logos/
└── chapters/
    ├── 00-preliminares.qmd
    ├── 01-modelo-supervivencia.qmd
    ├── 02-fuerza-mortalidad.qmd
    ├── 03-tablas-mortalidad.qmd
    ├── 04-probabilidades-expectativas.qmd
    ├── 05-valor-presente-actuarial.qmd
    ├── 06-seguros-vida.qmd
    ├── 07-anualidades-contingentes.qmd
    ├── 08-seguros-anualidades-continuos.qmd
    ├── 09-prima-neta-unica.qmd
    ├── 10-primas-periodicas.qmd
    ├── 11-reservas.qmd
    ├── 12-reservas-fraccionarias.qmd
    ├── 13-extensiones.qmd
    ├── 14-resumen-perspectivas.qmd
    ├── references.qmd
    └── apendice-glosario-notaciones.qmd
```

Las prácticas (ejercicios) pueden ser secciones dentro de cada capítulo o archivos dedicados (p. ej. `02-practica-parte-i.qmd`) según prefiera el equipo docente.

---

*Documento generado para el proyecto del libro *Introducción a las Matemáticas Actuariales*, CVEA / EECA-UCV. Material base: [Matemáticas Actuariales I PL II-2024, Google Drive](https://drive.google.com/drive/folders/1eD-0wb4dxDdgBI6reOzznviNyEVxHLym?usp=sharing).*
