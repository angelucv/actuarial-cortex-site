# Introducción a las Matemáticas Financieras

Libro en formato **Quarto Book** basado en el Trabajo Final de Pregrado (TFPG) **TFPG-FRANKLIN-QUERO-05-10-2025** (Franklin Quero, 2025). El contenido del libro corresponde a la **Guía Teórico-Práctica de Matemáticas Financieras I** (Anexo A de la tesis). Fuentes originales en `Referencias/TFPG/`:

- **TFPG-FRANKLIN-QUERO-05-10-2025.pdf**
- **TFPG-FRANKLIN-QUERO-05-10-2025.docx**

## Estructura del libro (alineada con la Guía)

| Parte / Capítulo | Archivo | Contenido |
|------------------|---------|-----------|
| Portada | `index.qmd` | Presentación, autor, referencia al TFPG |
| **Fundamentos** | | |
| Cap. 1: Medición del interés | `chapters/01-medicion-interes.qmd` | Función de acumulación, tasa efectiva, interés simple/compuesto, valor presente, tasa de descuento, tasas nominales, fuerza de interés |
| Práctica cap. 1 | `chapters/02-practica-cap1.qmd` | Ejercicios cap. 1 |
| Cap. 2: Resolución de problemas de interés | `chapters/03-resolucion-problemas-interes.qmd` | Problema básico, ecuación de valor, tiempo desconocido |
| Práctica cap. 2 | `chapters/04-practica-cap2.qmd` | Ejercicios cap. 2 |
| **Rentas (anualidades)** | | |
| Cap. 3: Rentas (anualidades ciertas) | `chapters/05-rentas-anualidades-ciertas.qmd` | Renta inmediata/anticipada, valores en cualquier fecha, perpetuidades |
| Cap. 4: Rentas más generales | `chapters/06-rentas-mas-generales.qmd` | Período de pago ≠ conversión, rentas continuas, progresiones aritmética/geométrica |
| Práctica cap. 3 y 4 | `chapters/07-practica-cap3-cap4.qmd` | Ejercicios rentas |
| Referencias | `chapters/references.qmd` | Bibliografía (BibTeX) |
| Apéndice: Glosario de notaciones | `chapters/apendice-glosario-notaciones.qmd` | Notación (Anexo B de la tesis) |

## Compilar en local

Desde la raíz del repositorio (cvea-platform):

```bash
quarto render libro/intro-matematicas-financieras/
```

O desde esta carpeta:

```bash
cd libro/intro-matematicas-financieras
quarto render
```

Salidas: HTML y PDF en `_book/`.

## Origen del contenido

El vaciado se realizó a partir del archivo **TFPG-FRANKLIN-QUERO-05-10-2025.docx**. La estructura y el contenido de los capítulos teóricos (1 a 4) y de las prácticas siguen el índice de la Guía (Anexo A). Las secciones de práctica incluyen ejercicios resueltos y propuestos; parte del contenido se ha incorporado desde la **colección Financieras I** (arqueo de 13 libros en `Referencias/Financieras I/`).

## Arqueo: colección Financieras I (13 libros)

Para vaciar contenido de los 13 libros de la carpeta **Referencias/Financieras I**, se utilizó extracción de texto desde PDF con **PyMuPDF** (pymupdf). Dependencia instalable con:

```bash
pip install pymupdf
```

El script `Referencias/Financieras I/extraer_pdfs.py` extrae el texto de todos los PDFs de esa carpeta y guarda los extractos en `Referencias/Financieras I/extractos/*.txt`. Tras ejecutar `python extraer_pdfs.py` desde dicha carpeta, el contenido de los extractos se utiliza para:

- Revisar definiciones, fórmulas y ejercicios resueltos.
- Incorporar ejercicios tipo y teoría complementaria en las prácticas del libro (con notación unificada $a_{\overline{n}|}$, $s_{\overline{n}|}$, etc.).

**Libros en formato .docx (9 títulos):** Varios de los libros de Financieras I están además disponibles en **.docx** en la misma carpeta, lo que permite una lectura y vaciado más profundo. Con **pandoc** se puede extraer texto plano: `pandoc "nombre.docx" -f docx -t plain -o "docx_extractos/nombre.txt"`. Los extractos en `docx_extractos/` se usan para ampliar la **teoría** del libro (no solo ejercicios): terminología, clasificación de anualidades, plazo/tasa/tiempo real y aproximado, descuento comercial y justo, ecuación de valor y aplicaciones (ventas a plazo, tarjetas de crédito, empeño, descuento por pronto pago).

**Libros incluidos en el arqueo:**

| # | Obra (extracto en `extractos/`) |
|---|----------------------------------|
| 1 | Julio César Andrade López — *Ejercicios resueltos de matemáticas financieras* (Ecoe, 2017) |
| 2 | Déniz Tadeo, García Boza, Jordán Sales et al. — *Problemas resueltos de matemática de las operaciones financieras* (Pirámide, 2016) |
| 3 | Alfredo Díaz Mata, Víctor M. Aguilera — *Matemáticas financieras* (McGraw-Hill, 2013) |
| 4 | Manuel Vidaurri Aguirre — *Matemáticas Financieras* (Cengage, 2017) |
| 5 | Héctor Vidaurri — *Matemáticas financieras*, Cap. 10 (Cengage, 2012) |
| 6 | J. L. Villalobos — *Matemáticas financieras* (Pearson, 2014) |
| 7 | Juan García Boza (coord.) — *Matemáticas financieras* (Pirámide, 2017) |
| 8 | Rubén O. López Haro, Arturo E. López Haro — *Comprendiendo las Matemáticas Financieras* (2021) |
| 9 | Leonardo Sampayo Naza — *Matemáticas financieras para las NIFF* (Univ. Externado, 2018) |
| 10 | Luis M. Pena-Levano, Edward Dowling — *Schaum's Outline of Mathematical Methods for Business, Economics and Finance* (McGraw-Hill, 2021) |
| 11 | Ernst Eberlein, Jan Kallsen — *Mathematical Finance* (Springer, 2019) |
| 12 | Emanuela Rosazza Gianin, Carlo Sgarra — *Mathematical Finance. Theory Review and Exercises* (Springer, 2023) |
| 13 | Claudio Pizzi et al. (eds.) — *Mathematical and statistical methods for actuarial sciences and finance (MAF 2022)* (2022) |

## Plantilla

La plantilla de libro está en Referencias (Quarto Book).
