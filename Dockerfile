FROM python:3.10-slim

# Kokoro için gerekli sistem kütüphaneleri
RUN apt-get update && apt-get install -y \
    espeak-ng \
    ffmpeg \
    gcc \
    g++ \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Önce bağımlılıkları yükleyelim
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Kokoro'nun kendisini de yükleyelim
RUN pip install kokoro>=0.9.4 soundfile

# Proje dosyalarını kopyala
COPY . .

# FastAPI'yi ayağa kaldır
# Not: Projenin giriş dosyası main.py ise alttaki komut çalışır
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
