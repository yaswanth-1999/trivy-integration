FROM python:3.11-alpine

# Install only required packages
RUN apk add --no-cache \
    build-base \
    libffi-dev

# Set working directory
WORKDIR /app

# Copy only requirements first (better caching)
COPY requirements.txt .

# Install dependencies safely
RUN pip install --no-cache-dir -r requirements.txt

# Copy app
COPY . .

# Run as non-root user (IMPORTANT for security)
RUN adduser -D appuser
USER appuser

CMD ["python", "app.py"]
