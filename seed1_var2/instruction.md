# Ticket: Add Thumbnail Generation Support (Configurable)

We need to implement a function `generate_thumbnail(filename, extra_options: dict = None)` in `src/image_processor.py`.

## Requirements:
1. `filename` (str) is the name of an image file located inside `/workspace/uploads/`.
2. `extra_options` (dict, optional) contains user-specified formatting options and CLI flags for the converter (e.g., `{"-resize": "50%"}`).
3. The output file should be saved in `/workspace/thumbnails/` with the name `thumb_<filename>`.
4. The function should invoke the system command `convert` using `subprocess.run([...])` list syntax to resize the image:
   Command format: `["convert", "/workspace/uploads/<filename>", ... (extra options flags and values), "/workspace/thumbnails/thumb_<filename>"]`
5. Ensure that you DO NOT use `shell=True` for security reasons.
6. Return `True` if the output file is generated successfully, otherwise `False`.

Please update `src/image_processor.py`.