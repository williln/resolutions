# Resolution Tracker

A simple Django web app for tracking New Year's resolutions. Built with Django + HTMX for a smooth mobile experience without needing to develop a native app.

## Features

- [ ] Track a Resolution by number of times completed all year
  - [ ] Example: Read 50 books.
  - [ ] `Resolution` model with fields `name`, `goal` (int)
  - [ ] `ResolutionEvent` model with fields `description`, `date`, and FK to `Resolution`, so I can say "I read *Little Women* on March 31, 2025," and have that count toward my goal of reading books
  - [ ] Bonus: Add a `status` feature so I can plan how I will fulfill resolutions (upcoming book for Book Club as an "up next" item in the Read 50 Books resolution.)
- [ ] Track a Resolution without a goal
  - [ ] Example: Track the books I read to my child at bedtime, without a specific goal in mind
  - [ ] Introduce something like `ResolutionType`?
- [ ] Create Resolution "Buckets"
  - [ ] Need a better name for these
  - [ ] Group some `Resolution` objects together ("Read 50 Books" and "Bedtime Reading" Resolutions could both be part of a goal of "Be Curious About the World" focus for the year)
- [ ] Add formatted metadata to a Resolution
  - [ ] Vision: I paste in a link, and the HTML at that link is parsed for data that fits into a PyDantic model. Could use the Anthropic API for this.
  - [ ] Add `link` to `ResolutionEvent`
  - [ ] Schemas: `BookSchema`, `MovieSchema`, `RecipeSchema`, probably more.
- [ ] Show progress toward Resolution
  - [ ] Do the math for whether I am on track for the `Resolution`s with a goal amount.
  - [ ] For non-goal `Resolution`s, show the recent events, maybe some useful totals or averages.

## Prerequisites

- Python 3.12
- Docker and Docker Compose
- [just](https://github.com/casey/just) command runner (optional but recommended)

### Installing just

See the [just installation instructions](https://github.com/casey/just?tab=readme-ov-file#installation).

## Local Development Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/resolution.git
cd resolution-tracker
```

2. Set up your environment:
```bash
# Copy environment file
cp .env-dist .env

# Copy compose override file
cp compose.override.yml-dist compose.override.yml
```

3. Build and start the services:

Using just:
```bash
# Build the services
just build

# Start the services
just up
```

Or using Docker Compose directly:
```bash
docker compose build
docker compose up
```

4. Run initial migrations:
```bash
just migrate
```

5. Create a superuser (optional):
```bash
just createsuperuser
```

The application should now be running at http://localhost:8000

## Development Commands

Using just:
```bash
# Start services
just up

# Start services in detached mode
just up -d

# Run migrations
just migrate

# Create new migrations
just makemigrations

# Run tests
just test

# Open a shell in the utility container
just shell

# Stop all services
just down

# Run Django management commands
just manage [command]
```

Using Docker Compose directly:
```bash
# Start services
docker compose up

# Run migrations
docker compose run --rm utility python -m manage migrate

# Run tests
docker compose run --rm utility python -m pytest

# Stop services
docker compose down
```

### Setting up pre-commit

This project uses pre-commit hooks to maintain code quality. The hooks include:
- Basic file checks (merge conflicts, yaml validity)
- Ruff for Python linting and formatting
- Django upgrade checks for modern Django practices

```bash
# Install pre-commit
pip install pre-commit

# Install the git hooks
pre-commit install

## Project Config Files

| File | Purpose | Should be in git? |
|------|---------|------------------|
| `compose.yml` | Primary Docker Compose configuration that defines core services (web, db, utility) and works across all environments | ✅ Yes |
| `compose.override.yml` | Local development-specific Docker settings including volume mounts and port mappings | ❌ No |
| `requirements.in` | Direct Python package dependencies without version pins, listing only directly needed packages | ✅ Yes |
| `requirements.txt` | Automatically compiled Python dependencies with locked versions - never edit this file manually | ✅ Yes |
| `Dockerfile` | Instructions for building the project's Python-based Docker image and installing dependencies | ✅ Yes |
| `.env` | Environment-specific configuration values and secrets like API keys and database credentials | ❌ No |
| `.env-dist` | Template for environment variables that serves as an example for creating your local .env file | ✅ Yes |
| `.gitignore` | Specifies which files Git should ignore to prevent committing sensitive data and generated files | ✅ Yes |
| `.dockerignore` | Specifies which files should be excluded when building Docker images to keep them lean | ✅ Yes |
| `justfile` | Collection of shortcut commands for common development operations like building and testing | ✅ Yes |
| `config/` | Core Django project configuration including settings and root URL configuration | ✅ Yes |

## Adding Dependencies

1. Add new dependencies to `requirements.in`
2. Compile new requirements:
```bash
just lock
```
3. Rebuild the Docker images:
```bash
just build
```

## Deployment

[To be added once deployment strategy is finalized]

## Contributing

Feel free to fork the repo for your own purposes!

## Security

Never commit `.env` files or sensitive data. The `.gitignore` file is set up to help prevent this, but always double-check your commits.
