# Dockerfile for StockStreaks MVP
FROM python:3.9-slim-buster

WORKDIR /app

# Environment setup (if needed, e.g., for non-interactive installs)
ENV DEBIAN_FRONTEND=noninteractive
ENV PYTHONUNBUFFERED=1

# Install OS-level dependencies if any
# RUN apt-get update && apt-get install -y ... && rm -rf /var/lib/apt/lists/*

COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

# Ensure data directory exists and is writable if needed by pipeline at runtime
# RUN mkdir -p /app/data && chown -R <someuser>:<somegroup> /app/data
# For release_command, this might not be strictly necessary if pipeline creates it.

EXPOSE 8080

# The pipeline will be run via the release_command in fly.toml
CMD ["gunicorn", "--bind", ":8080", "--workers", "4", "app:app"]
