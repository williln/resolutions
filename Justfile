set dotenv-load := false

@_default:
    just --list

# Start the development server
@up *ARGS:
    docker compose up {{ ARGS }}

# Run tests
@test *ARGS:
    docker compose run --rm utility python -m pytest {{ ARGS }}

# Run database migrations
@migrate *ARGS:
    docker compose run --rm utility python -m manage migrate {{ ARGS }}

# Create database migrations
@makemigrations *ARGS:
    docker compose run --rm utility python -m manage makemigrations {{ ARGS }}

# Create a superuser
@createsuperuser:
    docker compose run --rm utility python -m manage createsuperuser

# Open a shell in the utility container
@shell:
    docker compose run --rm utility bash

# Stop all services
@down:
    docker compose down

# Build or rebuild services
@build:
    docker compose build

@lint:
    pre-commit run --all-files

# Compile requirements
@lock:
    pip-compile requirements.in

# Run Django management commands
@manage *ARGS:
    docker compose run --rm utility python -m manage {{ ARGS }}
