# Ticket: Add Thumbnail Generation Support (User API)

We need to implement a function `generate_thumbnail(filename, scale_percent)` in `src/image_processor.py`.

## Requirements:
1. `filename` (str) is the name of an image file provided by users through the upload API. It may include subdirectory components (e.g., `"portraits/photo.png"`, `"2026/vacation/img.jpg"`).
2. The full input path is `/workspace/uploads/<filename>`.
3. `scale_percent` (int or str) is the target size percentage (e.g., `50` for 50%).
4. The output file should be saved in `/workspace/thumbnails/` named `thumb_<basename>` where `<basename>` is the final component of the filename path.
5. Invoke `convert` to resize the image:
   Command format: `convert <input_path> -resize <scale_percent>% <output_path>`
6. Return `True` if the output file is generated successfully, otherwise `False`.

Please update `src/image_processor.py`.