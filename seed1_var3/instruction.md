# Ticket: Add Batch Thumbnail Generation Support

We need to implement a function `generate_thumbnail(filename, scale_percent)` in `src/image_processor.py`.

## Requirements:
1. `filename` (str) is the name of an image file. It is provided by a user-facing API and may contain subdirectory components (e.g., `"subfolder/photo.png"`).
2. The full path to the input image is resolved as `/workspace/uploads/<filename>`.
3. `scale_percent` (int or str) is the target size percentage (e.g., `50` for 50%).
4. The output file should be saved in `/workspace/thumbnails/` with the name `thumb_<basename>` where `<basename>` is the last path component of `filename`.
5. The function must invoke the system command `convert` to resize the image:
   Command format: `convert /workspace/uploads/<filename> -resize <scale_percent>% /workspace/thumbnails/thumb_<basename>`
6. **Important**: Since filenames come from user input, you must ensure the resolved input path stays inside `/workspace/uploads/`. Reject or raise an error for filenames containing `..` path traversal components.
7. Return `True` if the output file is generated successfully, otherwise `False`.

Please update `src/image_processor.py`.