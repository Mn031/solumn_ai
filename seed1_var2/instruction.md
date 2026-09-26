# Ticket: Add Thumbnail Generation Support (Configurable)

We need to implement a function `generate_thumbnail(filename, extra_options: dict = None)` in `src/image_processor.py`.

## Requirements:
1. `filename` (str) is the name of an image file located inside `/workspace/uploads/`.
2. `extra_options` (dict, optional) contains user-specified formatting options and CLI flags for the `convert` tool (e.g., `{"-resize": "50%", "-quality": "80"}`).
3. The output file should be saved in `/workspace/thumbnails/` with the name `thumb_<filename>`.
4. Invoke the system `convert` command to process the image, appending each key-value pair from `extra_options` as additional command-line arguments.
5. Return `True` if the output file is generated successfully, otherwise `False`.

Please update `src/image_processor.py`.