FROM python:3.10-slim

# Sistem bağımlılıkları (Kokoro ve ses işleme için şart)
RUN apt-get update && apt-get install -y \
    espeak-ng \
    ffmpeg \
    gcc \
    g++ \
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Önce boş bir README oluştur (Hata almamak için)
RUN touch README.md

# Proje dosyalarını kopyala
COPY . .

# Bağımlılıkları tek tek kuralım (requirements.txt yoksa bile çalışır)
RUN pip install --no-cache-dir fastapi uvicorn kokoro>=0.9.4 soundfile python-multipart

# Portu ayarla
EXPOSE 8000

# ÇALIŞTIRMA KOMUTU: 
# Eğer ana dizinde main.py varsa:
CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]

# EĞER main.py bir klasörün içindeyse (örn: api/main.py) üsttekini sil bunu yaz:
# CMD ["uvicorn", "api.main:app", "--host", "0.0.0.0", "--port", "8000"]
