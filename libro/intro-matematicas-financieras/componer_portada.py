# -*- coding: utf-8 -*-
"""Componer portada: logo CVEA + Ediciones CVEA + título + Enfoque Actuarial.
   Fondo a máxima calidad cubriendo todo el recuadro; logo grande."""
from pathlib import Path

try:
    from PIL import Image, ImageDraw, ImageFont
except ImportError:
    print("Instalando Pillow...")
    import subprocess
    subprocess.check_call(["pip", "install", "Pillow", "-q"])
    from PIL import Image, ImageDraw, ImageFont

# Rutas
DIR = Path(__file__).resolve().parent
BASE_PATHS = [
    DIR / "portada-fondo-hq.png",
    DIR / "portada-base.png",
    Path(r"C:\Users\Angel\.cursor\projects\c-Users-Angel-cvea-platform\assets\portada-fondo-hq.png"),
    Path(r"C:\Users\Angel\.cursor\projects\c-Users-Angel-cvea-platform\assets\portada-base-3-sin-icono.png"),
]
LOGO_PATH = DIR.parent.parent / "_site" / "assets" / "logos" / "Logo-CVEA-horizontal-grande-letrasblancas.png"
OUT_PATH = DIR / "portada-final.png"

# Tamaño de salida en alta resolución (portada libro ~300 DPI para 8x10" ≈ 2400x3000)
TARGET_W = 2550
TARGET_H = 3600


def resize_cover_fill(img: Image.Image, target_w: int, target_h: int) -> Image.Image:
    """Redimensiona la imagen para CUBRIR todo el recuadro (sin barras, sin huecos)."""
    iw, ih = img.size
    scale = max(target_w / iw, target_h / ih)
    new_w = int(iw * scale + 0.5)
    new_h = int(ih * scale + 0.5)
    resized = img.resize((new_w, new_h), Image.Resampling.LANCZOS)
    # Recorte centrado al tamaño exacto
    x = (new_w - target_w) // 2
    y = (new_h - target_h) // 2
    return resized.crop((x, y, x + target_w, y + target_h))


def main():
    # Cargar imagen de fondo
    raw = None
    for p in BASE_PATHS:
        if p.exists():
            raw = Image.open(p).convert("RGBA")
            break
    if raw is None:
        raise FileNotFoundError(
            "No se encontró imagen de fondo. Copia portada-fondo-hq.png o portada-base.png a la carpeta del libro."
        )
    # Canvas de salida en alta resolución con fondo que cubre TODO el recuadro
    base = resize_cover_fill(raw, TARGET_W, TARGET_H)
    w, h = TARGET_W, TARGET_H

    # Cargar logo y hacerlo MÁS GRANDE (buena parte de la página)
    if not LOGO_PATH.exists():
        raise FileNotFoundError(f"Logo no encontrado: {LOGO_PATH}")
    logo = Image.open(LOGO_PATH).convert("RGBA")
    # Logo grande: ~68% del ancho de la portada
    logo_w_max = int(w * 0.68)
    ratio = logo_w_max / logo.size[0]
    new_logo_size = (logo_w_max, int(logo.size[1] * ratio))
    logo = logo.resize(new_logo_size, Image.Resampling.LANCZOS)
    lw, lh = logo.size
    margin = int(w * 0.055)
    y_logo = margin
    x_logo = margin
    base.paste(logo, (x_logo, y_logo), logo if logo.mode == "RGBA" else None)

    # Textos (tamaños proporcionales a la alta resolución)
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
    y_ed = y_logo + lh + int(h * 0.022)
    draw.text((x_logo, y_ed), "Ediciones CVEA", fill=white, font=font_ed)

    x_tit = int(w * 0.05)
    y_tit = int(h * 0.38)
    line1 = "Introducción a"
    line2 = "Matemáticas Financieras"
    draw.text((x_tit, y_tit), line1, fill=white, font=font_tit)
    draw.text((x_tit, y_tit + int(h * 0.070)), line2, fill=white, font=font_tit)

    y_sub = y_tit + int(h * 0.070) * 2 + int(h * 0.024)
    draw.text((x_tit, y_sub), "Enfoque Actuarial", fill=white, font=font_sub)

    # Guardar a MÁXIMA calidad (PNG sin compresión pérdida, quality máximo para compatibilidad)
    base.convert("RGB").save(OUT_PATH, "PNG", compress_level=1)
    print(f"Portada guardada ({w}x{h} px): {OUT_PATH}")

if __name__ == "__main__":
    main()
