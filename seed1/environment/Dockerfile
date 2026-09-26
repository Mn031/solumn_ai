FROM python:3.11-slim

RUN apt-get update && apt-get install -y imagemagick curl && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir uv==0.9.7 pytest==8.4.1 pytest-json-ctrf==0.3.5

WORKDIR /workspace

# Set up work directories and a test secret file outside uploads
RUN mkdir -p /workspace/uploads /workspace/thumbnails /workspace/src
RUN echo "iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAADUlEQVR42mNk+M9QDwADhgGAWjR9awAAAABJRU5ErkJggg==" | base64 -d > /workspace/uploads/test.png
RUN echo "CONFIDENTIAL_FLAG_12345" > /workspace/secret.txt

COPY src/ /workspace/src/

ENV PYTHONPATH=/workspace/src

CMD ["/bin/bash"]