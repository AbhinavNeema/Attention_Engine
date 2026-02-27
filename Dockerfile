FROM python:3.10-slim

WORKDIR /app

# Install system dependencies required by mediapipe/opencv + wget for model download
RUN apt-get update && apt-get install -y \
    wget \
    libglib2.0-0 \
    libgl1 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Create models directory
RUN mkdir -p models

# Download MediaPipe models during build
RUN wget -O models/face_detector.tflite \
    https://storage.googleapis.com/mediapipe-assets/face_detector.tflite

RUN wget -O models/face_landmarker.task \
    https://storage.googleapis.com/mediapipe-assets/face_landmarker.task

ENV PORT=7860
EXPOSE 7860

CMD ["gunicorn", "app:app", "-b", "0.0.0.0:7860", "--workers", "1", "--timeout", "120"]