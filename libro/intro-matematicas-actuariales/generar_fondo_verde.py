# -*- coding: utf-8 -*-
"""Genera el fondo de portada en tonos verdes a partir de la imagen de Financieras.
   Mantiene el mismo estilo: diagonal nítida de esquina inferior izq. a superior der."""
from pathlib import Path
import colorsys

try:
    from PIL import Image
except ImportError:
    import subprocess
    subprocess.check_call(["pip", "install", "Pillow", "-q"])
    from PIL import Image

DIR = Path(__file__).resolve().parent
FINANCIERAS_FONDOS = [
    DIR.parent / "intro-matematicas-financieras" / "portada-fondo-hq.png",
    DIR.parent / "intro-matematicas-financieras" / "portada-base.png",
]
OUT_PATH = DIR / "portada-actuariales-diagonal-verde.png"

# Color institucional CVEA: teal #38666A (assets/styles.css: --cvea-teal)
# H en [0,1]: azul≈0.67, teal CVEA≈0.51. Solo cambia el tono; las formas se mantienen.
HUE_SHIFT = -0.16  # azul original -> teal/verde institucional CVEA
# Bajar la diagonal para que no se superponga al título (fracción de la altura)
LINE_SHIFT_DOWN_RATIO = 0.22
# Shear horizontal: pendiente menos pronunciada (la diagonal se suaviza). ~2.5% del ancho sobre la altura.
SHEAR_FACTOR = 0.025


def rgb_to_rgb_hue_shift(r, g, b):
    r, g, b = r / 255.0, g / 255.0, b / 255.0
    h, s, v = colorsys.rgb_to_hsv(r, g, b)
    h = (h + HUE_SHIFT) % 1.0
    r, g, b = colorsys.hsv_to_rgb(h, s, v)
    return (int(round(r * 255)), int(round(g * 255)), int(round(b * 255)))


def main():
    img_path = None
    for p in FINANCIERAS_FONDOS:
        if p.exists():
            img_path = p
            break
    if not img_path:
        raise FileNotFoundError(
            "No se encontró imagen de Financieras. Rutas: " + str(FINANCIERAS_FONDOS)
        )
    img = Image.open(img_path).convert("RGB")
    w, h = img.size
    pixels = img.load()
    for y in range(h):
        for x in range(w):
            pixels[x, y] = rgb_to_rgb_hue_shift(*pixels[x, y])

    # Shear horizontal: pendiente de la diagonal un poco menos pronunciada
    if SHEAR_FACTOR != 0:
        shear_out = Image.new("RGB", (w, h))
        shear_pix = shear_out.load()
        for y in range(h):
            offset = int(SHEAR_FACTOR * w * y / h)
            for x in range(w):
                src_x = min(w - 1, max(0, x - offset))
                shear_pix[x, y] = pixels[src_x, y]
        img = shear_out
        pixels = img.load()

    # Bajar la diagonal: desplazar el contenido hacia abajo para que no tape el título
    shift = int(h * LINE_SHIFT_DOWN_RATIO)
    if shift > 0:
        out = Image.new("RGB", (w, h))
        out_pix = out.load()
        for y in range(h):
            src_y = y - shift if y >= shift else 0
            for x in range(w):
                out_pix[x, y] = pixels[x, src_y]
        img = out
        pixels = img.load()

    img.save(OUT_PATH, "PNG", compress_level=6)
    print(f"Fondo verde generado (mismo estilo que Financieras): {OUT_PATH}")


if __name__ == "__main__":
    main()
