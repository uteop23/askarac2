# Menggunakan base image Python resmi
FROM python:3.9-slim

# Menetapkan direktori kerja di dalam container
WORKDIR /app

# Menginstall FFmpeg dan library lain yang dibutuhkan sistem
RUN apt-get update && apt-get install -y --no-install-recommends ffmpeg && rm -rf /var/lib/apt/lists/*

# Menyalin file requirements dan menginstall library Python
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Menyalin sisa kode aplikasi
COPY . .

# Menjalankan server menggunakan Gunicorn.
# Railway akan secara otomatis menyediakan variabel $PORT.
CMD exec gunicorn server:app --bind :$PORT --timeout 900
