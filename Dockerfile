FROM python:3.11-alpine

# Set working directory
WORKDIR /app

# Install only required system packages (minimal)
RUN apk add --no-cache libffi

# Copy dependency file first (for caching)
COPY requirements.txt .

# Install Python dependencies safely
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code
COPY . .

# Create non-root user (security best practice)
RUN adduser -D appuser
USER appuser

# Run app
CMD ["python", "app.py"]
