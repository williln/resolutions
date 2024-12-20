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

## Development Setup

### Prerequisites
- Python 3.12
- Docker and Docker Compose
- [just](https://github.com/casey/just?tab=readme-ov-file#installation) command runner (recommended)

### Local Setup

1. Clone and prepare environment:
```bash
git clone https://github.com/yourusername/resolution.git
cd resolution-tracker
cp .env-dist .env
cp compose.override.yml-dist compose.override.yml
```

2. Start development environment:
```bash
just build
just up
just migrate
just createsuperuser
```

The app will be available at http://localhost:8000

### Development Commands

Using just (recommended):
```bash
just up              # Start services
just down            # Stop services
just migrate         # Run migrations
just makemigrations  # Create migrations
just test            # Run tests
just shell           # Open utility shell
just manage [cmd]    # Run Django commands
```

### Code Quality

Setup pre-commit hooks:
```bash
pip install pre-commit
pre-commit install
```

Includes:
- Basic file checks
- Ruff for Python linting/formatting
- Django upgrade checks

### Dependencies

Add new packages:
1. Add to `requirements.in`
2. Run `just lock`
3. Run `just build`

## Deployment

The project deploys to Fly.io using GitHub Actions for CI/CD.

### Initial Setup

1. Install and authenticate Fly CLI:
```bash
brew install flyctl
fly auth login
```

2. Create Fly.io app:
```bash
fly launch
```

3. Set up secrets:
```bash
fly secrets set SECRET_KEY="your-django-secret-key" DEBUG="False"
```

### CI/CD Setup

1. Create deployment token:
```bash
fly tokens create deploy -x 999999h
```

2. Add token to GitHub:
   - Repository Settings → Secrets → Actions
   - Create `FLY_API_TOKEN` with token value

The GitHub Action will automatically deploy main branch changes to Fly.io.

### Deployment Commands

```bash
fly deploy            # Manual deploy
fly status           # Check app status
fly logs             # View logs
fly scale show       # View resources
fly postgres connect # Access database
```

## Project Files

| File | Purpose | In Git? |
|------|---------|---------|
| `compose.yml` | Main Docker Compose config | ✅ |
| `compose.override.yml` | Local Docker overrides | ❌ |
| `requirements.in` | Direct dependencies | ✅ |
| `requirements.txt` | Locked dependencies | ✅ |
| `Dockerfile` | Production build config | ✅ |
| `Dockerfile.dev` | Development build config | ✅ |
| `.env` | Environment variables | ❌ |
| `.env-dist` | Environment template | ✅ |
| `fly.toml` | Fly.io configuration | ✅ |
| `.github/workflows/deploy.yml` | CI/CD configuration | ✅ |

## Security

- Never commit `.env` files or secrets
- Use `fly secrets` for production values
- Check the `.gitignore` file for excluded patterns

## Contributing

Feel free to fork the repo for your own purposes!
