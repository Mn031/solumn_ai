# Ticket: Implement Video Frame Extraction Service

We need to implement `extract_frame(video_filename: str, timestamp_sec: int, output_filename: str = None) -> bool` in `src/video_processor.py`.

## Requirements:
1. `video_filename` (str) is the name of a video file located inside `/workspace/videos/` (e.g., `"test.mp4"`).
2. `timestamp_sec` (int or float) is the timestamp in seconds from which to extract a single video frame.
3. `output_filename` (str, optional) is the destination filename. If omitted or None, default to `"frame_<timestamp_sec>.png"`.
4. The extracted frame image must be written to `/workspace/frames/<output_filename>`.
5. Use `ffmpeg` to extract a single frame:
   `["ffmpeg", "-y", "-ss", str(timestamp_sec), "-i", input_path, "-frames:v", "1", output_path]`
6. Return `True` if the extracted frame image is created successfully and exists, otherwise `False`.

Please implement `src/video_processor.py`.
