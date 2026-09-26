FROM python:3.11-slim

RUN apt-get update && apt-get install -y ffmpeg curl && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir uv==0.9.7 pytest==8.4.1 pytest-json-ctrf==0.3.5

WORKDIR /workspace

# Set up directories and sample test video
RUN mkdir -p /workspace/videos /workspace/frames /workspace/src
RUN ffmpeg -f lavfi -i testsrc=duration=2:size=320x240:rate=1 /workspace/videos/test.mp4
RUN echo "CONFIDENTIAL_FRAME_SECRET_77665" > /workspace/secret.txt

COPY src/ /workspace/src/

ENV PYTHONPATH=/workspace/src

CMD ["/bin/bash"]
