"""
Post-render script: elimina la primera página del PDF del libro
para quitar la página en blanco que inserta la plantilla/clase antes de la portada.

Uso: se ejecuta automáticamente tras `quarto render --to pdf` si está en
_quarto.yml como project.post-render.

Variables de entorno (Quarto): QUARTO_PROJECT_OUTPUT_DIR, QUARTO_PROJECT_OUTPUT_FILES
"""
import os
import sys

def main():
    output_dir = os.environ.get("QUARTO_PROJECT_OUTPUT_DIR", "_book")
    output_files = os.environ.get("QUARTO_PROJECT_OUTPUT_FILES", "").strip().split("\n")
    project_dir = os.getcwd()

    # Buscar PDFs a procesar
    pdf_paths = []
    for f in output_files:
        if f and f.endswith(".pdf"):
            p = os.path.join(project_dir, f.strip())
            if os.path.isfile(p):
                pdf_paths.append(p)
    if not pdf_paths:
        # Fallback: buscar en _book
        book_dir = os.path.join(project_dir, "_book")
        if os.path.isdir(book_dir):
            for name in os.listdir(book_dir):
                if name.endswith(".pdf"):
                    pdf_paths.append(os.path.join(book_dir, name))

    if not pdf_paths:
        print("remove_first_pdf_page: no se encontró ningún PDF generado.", file=sys.stderr)
        return 0

    try:
        from pypdf import PdfReader, PdfWriter
    except ImportError:
        try:
            from PyPDF2 import PdfReader, PdfWriter
        except ImportError:
            print("remove_first_pdf_page: instala 'pypdf' o 'PyPDF2' (pip install pypdf)", file=sys.stderr)
            return 1

    for pdf_path in pdf_paths:
        try:
            reader = PdfReader(pdf_path)
            n = len(reader.pages)
            if n < 2:
                print(f"remove_first_pdf_page: PDF tiene solo {n} página(s), no se modifica.", file=sys.stderr)
                continue
            writer = PdfWriter()
            for i in range(1, n):
                writer.add_page(reader.pages[i])
            with open(pdf_path, "wb") as out:
                writer.write(out)
            print(f"remove_first_pdf_page: eliminada la primera página de {os.path.basename(pdf_path)}")
        except Exception as e:
            print(f"remove_first_pdf_page: error en {pdf_path}: {e}", file=sys.stderr)
            return 1
    return 0

if __name__ == "__main__":
    sys.exit(main())
