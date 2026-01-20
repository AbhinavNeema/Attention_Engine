# Attention Engine (Flask + MediaPipe)

A real-time attention detection engine using webcam frames.

## Features
- Face detection confidence
- Gaze alignment score
- Head orientation score
- Optimized for LMS / video platforms

## Tech Stack
- Flask
- MediaPipe
- OpenCV (headless)
- NumPy

## API

### POST /analyze
Send a frame as multipart/form-data

Key: frame  
Value: image/jpeg

Response:
```json
{
  "face_conf": 0.91,
  "gaze_conf": 0.84,
  "head_conf": 0.79
}

