FROM python:3.12-slim

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Dependencias de compilación para posibles wheels (cryptography, bcrypt)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copia del código
COPY . .

# Puerto por defecto, Railway provee PORT
ENV PORT=8000

# Ejecuta la app leyendo PORT
CMD ["python", "app/main.py"]

