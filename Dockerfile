# Use the official Python image from the Docker hub
FROM python:3.11-slim as builder

# Set the working directory in the final image
WORKDIR /app

# Copy installed packages from the builder
COPY app.py .

# Install the zoneinfo package for time zone support
RUN pip install tzdata

# Expose port 3030 for the application
EXPOSE 3030

# Command to run the Flask application
CMD ["python", "app.py"]
