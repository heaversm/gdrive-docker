# Use an official Python runtime as a parent image
FROM python:3.11

# Set the working directory in the container to /app
WORKDIR /gdrive

# Add the current directory contents into the container at /app
ADD /gdrive /gdrive

# Install any needed packages specified in pyproject.toml
RUN pip install poetry==1.7.1
RUN poetry config virtualenvs.in-project false
RUN poetry install --no-root

RUN --mount=type=secret,id=_env,dst=/etc/secrets/.env

# Make port 80 available to the world outside this container
EXPOSE 5000

# Run the application when the container launches
CMD ["poetry", "run", "flask", "--app", "provider", "--debug", "run", "--host", "0.0.0.0", "--port", "5000"]