FROM python:3.11-slim@sha256:e41613d42d4891e4930f79523f93f81bbc7632584ec65e36ab055f41a800b41e

RUN apt-get update && apt-get install -y imagemagick curl && rm -rf /var/lib/apt/lists/*
RUN pip install --no-cache-dir uv==0.9.7 pytest==8.4.1 pytest-json-ctrf==0.3.5

WORKDIR /workspace

# Set up work directories and a test secret file outside uploads
RUN mkdir -p /workspace/uploads /workspace/thumbnails /workspace/src
RUN convert -size 100x100 xc:blue /workspace/uploads/test.png
RUN mkdir -p /workspace/uploads/gallery && convert -size 100x100 xc:green /workspace/uploads/gallery/photo.png
RUN echo "CONFIDENTIAL_FLAG_12345" > /workspace/secret.txt

COPY src/ /workspace/src/

ENV PYTHONPATH=/workspace/src

CMD ["/bin/bash"]