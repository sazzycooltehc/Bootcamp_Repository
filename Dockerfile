# Use an official Python runtime as a parent image
FROM python:3.12-slim

# Install system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install uv
RUN curl -LsSf https://astral.sh/uv/install.sh | sh
ENV PATH="/root/.local/bin:$PATH"

# Set the working directory in the container
WORKDIR /app

# Copy dependency files first (better Docker layer caching)
COPY pyproject.toml uv.lock ./

# Copy the rest of the application
COPY . /app

# Install dependencies using uv
RUN uv sync --frozen --no-cache

# Make port 80 available to the world outside this container
EXPOSE 80

# Define environment variable
ENV NAME=BootcampApp

# Run the application
CMD ["python", "script_1.py"]