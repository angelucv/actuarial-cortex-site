# -*- coding: utf-8 -*-
"""Componer portada Actuariales: fondo verde + logo CVEA horizontal + Ediciones CVEA + título + subtítulo.
   Misma tipografía que Financieras: Arial para todo el texto."""
from pathlib import Path

try:
    from PIL import Image, ImageDraw, ImageFont
except ImportError:
    import subprocess
    subprocess.check_call(["pip", "install", "Pillow", "-q"])
    from PIL import Image, ImageDraw, ImageFont

DIR = Path(__file__).resolve().parent
BASE_PATHS = [
    DIR / "portada-actuariales-diagonal-verde.png",  # Diagonal inferior izq → superior der, tonos verdes
    DIR / "portada-actuariales-solo-fondo.png",
    DIR / "portada-actuariales-fondo-sin-logo.png",
    DIR / "portada-actuariales-propuesta.png",
]
OUT_PATH = DIR / "portada-final.png"

# Mismo tamaño de salida que Financieras (alta resolución)
TARGET_W = 2550
TARGET_H = 3600

LOGO_PATHS = [
    DIR / "assets" / "logos" / "Logo-CVEA-horizontal-grande-letrasblancas.png",
    DIR.parent.parent / "assets" / "logos" / "Logo-CVEA-horizontal-grande-letrasblancas.png",
    DIR.parent.parent / "Referencias" / "Logos" / "Logo-CVEA-horizontal-grande-letrasblancas.png",
    Path(r"C:\Users\Angel\cvea-platform\assets\logos\Logo-CVEA-horizontal-grande-letrasblancas.png"),
]

LOGO_WIDTH_RATIO = 0.68
MARGIN_RATIO = 0.055
EDICIONES_GAP_RATIO = 0.022


def resize_cover_fill(img, target_w, target_h):
    """Redimensiona la imagen para cubrir todo el recuadro (como en Financieras)."""
    iw, ih = img.size
    scale = max(target_w / iw, target_h / ih)
    new_w = int(iw * scale + 0.5)
    new_h = int(ih * scale + 0.5)
    resized = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
    x = (new_w - target_w) // 2
    y = (new_h - target_h) // 2
    return resized.crop((x, y, x + target_w, y + target_h))


def main():
    raw = None
    for p in BASE_PATHS:
        if p.exists():
            raw = Image.open(p).convert("RGBA")
            break
    if raw is None:
        raise FileNotFoundError("No se encontró imagen de fondo. Ejecuta desde la carpeta del libro.")
    base = resize_cover_fill(raw, TARGET_W, TARGET_H)
    w, h = TARGET_W, TARGET_H

    logo_path = None
    for p in LOGO_PATHS:
        if p.exists():
            logo_path = p
            break
    if not logo_path:
        raise FileNotFoundError("Logo no encontrado: Logo-CVEA-horizontal-grande-letrasblancas.png")

    # Bloque superior izquierdo: logo y "Ediciones CVEA" alineados al mismo margen
    margin_left = int(w * MARGIN_RATIO)
    margin_top = int(h * MARGIN_RATIO)
    x_block = margin_left
    y_logo = margin_top

    logo = Image.open(logo_path).convert("RGBA")
    logo_w_max = int(w * LOGO_WIDTH_RATIO)
    ratio = logo_w_max / logo.size[0]
    new_logo_h = int(logo.size[1] * ratio)
    logo = logo.resize((logo_w_max, new_logo_h), Image.Resampling.LANCZOS)
    lw, lh = logo.size
    base.paste(logo, (x_block, y_logo), logo)

    # Textos con Arial, mismos tamaños proporcionales que Financieras
    draw = ImageDraw.Draw(base)
    try:
        font_ed = ImageFont.truetype("arial.ttf", int(h * 0.030))
        font_tit = ImageFont.truetype("arial.ttf", int(h * 0.056))
        font_sub = ImageFont.truetype("arial.ttf", int(h * 0.040))
    except Exception:
        font_ed = ImageFont.load_default()
        font_tit = font_ed
        font_sub = font_ed

    white = (255, 255, 255)
    # "Ediciones CVEA" justo debajo del logo, misma alineación izquierda
    y_ed = y_logo + lh + int(h * EDICIONES_GAP_RATIO)
    draw.text((x_block, y_ed), "Ediciones CVEA", fill=white, font=font_ed)

    # Título y subtítulo (misma disposición que Financieras)
    x_tit = int(w * 0.05)
    y_tit = int(h * 0.38)
    line1 = "Introducción a las"
    line2 = "Matemáticas Actuariales"
    draw.text((x_tit, y_tit), line1, fill=white, font=font_tit)
    draw.text((x_tit, y_tit + int(h * 0.070)), line2, fill=white, font=font_tit)
    # Subtítulo en dos líneas para no salir del margen
    line_gap = int(h * 0.024)
    y_sub1 = y_tit + int(h * 0.070) * 2 + line_gap
    draw.text((x_tit, y_sub1), "Material docente", fill=white, font=font_sub)
    draw.text((x_tit, y_sub1 + int(h * 0.040) + int(h * 0.012)), "Matemáticas Actuariales I", fill=white, font=font_sub)

    base.convert("RGB").save(OUT_PATH, "PNG", compress_level=1)
    print(f"Portada guardada ({w}x{h} px): {OUT_PATH}")


if __name__ == "__main__":
    main()
