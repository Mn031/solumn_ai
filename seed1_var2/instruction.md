# Ticket: Implement Document Conversion Pipeline with CLI Options

We need to implement `convert_document(filename: str, extra_options: dict = None) -> bool` in `src/doc_processor.py`.

## Requirements:
1. `filename` (str) is the name of a document file located inside `/workspace/docs/` (e.g., `"document.md"`).
2. `extra_options` (dict, optional) contains user-specified formatting options and CLI flags for the converter (e.g., `{"format": "html", "standalone": True}`).
3. The converted output file must be saved to `/workspace/converted/<basename>.<format>` where `<basename>` is the input filename without extension and `<format>` defaults to `"html"` (or as specified in `extra_options["format"]`).
4. Invoke `pandoc` using `subprocess.run([...])` list syntax to perform the conversion:
   `["pandoc", input_path, "-o", output_path, ...]` appending formatted CLI arguments from `extra_options`.
5. Return `True` if the converted document is created successfully and exists, otherwise `False`.

Please implement `src/doc_processor.py`.
