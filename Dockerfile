FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=off \
    PIP_DISABLE_PIP_VERSION_CHECK=on \
    PIP_DEFAULT_TIMEOUT=100 \
    PORT=8000

WORKDIR /code

COPY requirements.txt .
RUN pip install -r requirements.txt gunicorn

COPY . .

CMD gunicorn config.wsgi:application --bind 0.0.0.0:8000
