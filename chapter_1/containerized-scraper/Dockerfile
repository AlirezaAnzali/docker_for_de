FROM python:3.11-slim

WORKDIR /app

# Install deps first (better caching)
COPY app/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the code
COPY app/scraper.py .

# Default output dir inside container
ENV OUTPUT_DIR=/data

CMD ["python", "scraper.py"]