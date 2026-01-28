import os
import sys
import argparse
from pathlib import Path


def _ensure_stdio():
    if getattr(sys, "stdout", None) is None:
        nul = "NUL" if os.name == "nt" else "/dev/null"
        sys.stdout = open(nul, "w", encoding="utf-8", errors="replace")

    if getattr(sys, "stderr", None) is None:
        nul = "NUL" if os.name == "nt" else "/dev/null"
        sys.stderr = open(nul, "w", encoding="utf-8", errors="replace")

_ensure_stdio()



def pdf_to_docx (pdf_path:Path,out_path:Path ):
  from pdf2docx import Converter
  cv = Converter(str(pdf_path))
  try:
    cv.convert(str(out_path))

  finally:
    cv.close()
    
def docx_to_pdf (docx_path:Path, out_path:Path):
  from docx2pdf import convert
  convert(str(docx_path), str(out_path))




def resource_path(relative: str) -> Path:
    if getattr(sys, "_MEIPASS", None):
        base = Path(sys._MEIPASS)
    else:
        base = Path(__file__).parent
    return base / relative



def get_unique_path(path: Path) -> Path:
    if not path.exists():
        return path
    stem = path.stem  
    parent = path.parent
    suffix = path.suffix  
    i = 1
    while True:
        candidate = parent / f"{stem}_{i}{suffix}"
        if not candidate.exists():
            return candidate
        i += 1


        

def main():
  parser = argparse.ArgumentParser(description="this is the file conversion program ")
  parser.add_argument("file", help="Path to file (Explorer passes %1)")
  parser.add_argument("--overwrite", action="store_true", help="Overwrite existing output file")
  arg = parser.parse_args()

  p = Path(arg.file).expanduser().resolve()
  if not p.exists():
    print("error file does not exist", p)
    sys.exit(2)

  ext = p.suffix.lower()
  out = None
   
   # form pdf to docx conversion 
  if ext == ".pdf":
    out = p.with_suffix(".docx")
    if out.exists() and not arg.overwrite:
      new_out = get_unique_path(out)
      print(f"output {out} already exists. Using {new_out}")
      out = new_out
      
    print(f"converting {p} to docx -> {out}")
    try:
      pdf_to_docx(p,out)  
      print("done")
    except Exception as e:
      print("Conversion failed:", e)  
      sys.exit(1)


  elif ext == ".docx":
    out = p.with_suffix(".pdf")
    if out.exists() and not arg.overwrite:
      new_out = get_unique_path(out)
      print(f"output {out} already exists. Using {new_out}")
      out = new_out


    print(f"converting {p} to pdf -> {out}")
    try:
      docx_to_pdf(p,out)
      print("done")
    except Exception as e:
      print(f"Conversion failed: {e.__class__.__name__}: {e}") 
      sys.exit(1)


  else: 
    print("unsupported file type ", ext)
    sys.exit(4)     

if __name__ == "__main__":
  main()    