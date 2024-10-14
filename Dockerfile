# # Use the official Python base image
# FROM python:3.10

# # Set the working directory in the container
# WORKDIR /app

# # Copy the application code into the container
# COPY . acebet

# # Install the application package
# RUN pip install --upgrade pip
# RUN pip install -U ./acebet

# # Expose the port that the FastAPI app will run on
# EXPOSE 80

# # Run the FastAPI app using the full path to the module
# CMD ["uvicorn", "acebet.app.main:app", "--host", "0.0.0.0", "--port", "80"]


FROM python:3.10-slim

# Install uv.
COPY --from=ghcr.io/astral-sh/uv:latest /uv /bin/uv

# Set the working directory in the container
WORKDIR /app

# Copy the application code into the container
COPY . acebet

RUN uv sync --frozen --no-cache

# Run the application.
CMD ["/app/.venv/bin/fastapi", "run", "app/main.py", "--port", "80", "--host", "0.0.0.0"]