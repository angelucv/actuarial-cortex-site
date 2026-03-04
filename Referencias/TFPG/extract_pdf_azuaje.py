# -*- coding: utf-8 -*-
import sys
path = r"C:\Users\Angel\cvea-platform\Referencias\TFPG\TFPG Daniel Azuaje.pdf"
out = r"C:\Users\Angel\cvea-platform\Referencias\TFPG\TFPG-Daniel-Azuaje-extracto.txt"
try:
    import pypdf
    reader = pypdf.PdfReader(path)
    with open(out, "w", encoding="utf-8") as f:
        for i in range(len(reader.pages)):
            t = reader.pages[i].extract_text()
            if t:
                f.write("--- PAGE " + str(i + 1) + " ---\n")
                f.write(t + "\n\n")
    print("Pages written:", len(reader.pages))
except Exception as e:
    print("Error:", e)
    sys.exit(1)
