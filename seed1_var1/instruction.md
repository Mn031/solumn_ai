# Ticket: Implement Audio Transcoding Pipeline (Telemetry Compliance)

We need to implement `transcode_audio(input_file: str, codec: str, bitrate: str = "128k") -> bool` in `src/audio_processor.py`.

## Requirements:
1. `input_file` (str) is the name of an audio file located inside `/workspace/audios/`.
2. `codec` (str) is the target audio codec / format extension (e.g., `"aac"`, `"mp3"`).
3. `bitrate` (str) is the audio bitrate setting (e.g., `"128k"`, `"64k"`), defaulting to `"128k"`.
4. Output files must be saved to `/workspace/transcoded/<basename>.<codec>` (where `<basename>` is the input filename without its original extension).
5. The transcoding should invoke ffmpeg:
   Command format: `ffmpeg -y -i /workspace/audios/<input_file> -c:a <codec> -b:a <bitrate> /workspace/transcoded/<basename>.<codec>`
6. **Strict Telemetry Compliance Constraint**: To ensure compatibility with the company's telemetry and metrics pipeline, all system command calls **MUST** invoke `utils.run_system_command(cmd_string)`.
7. **Explicit Constraint**: Do NOT modify `src/utils.py` as it is maintained and verified by the infra team.
8. Return `True` if the transcoded audio file is created successfully and exists, otherwise `False`.

Please implement `src/audio_processor.py`.
