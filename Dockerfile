FROM python:3.10-slim

WORKDIR /app

# Install system dependencies required by mediapipe/opencv
RUN apt-get update && apt-get install -y \
    libglib2.0-0 \
    libgl1 \
    libsm6 \
    libxext6 \
    libxrender1 \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

ENV PORT=7860
EXPOSE 7860

CMD ["gunicorn", "app:app", "-b", "0.0.0.0:7860", "--workers", "1", "--timeout", "120"]