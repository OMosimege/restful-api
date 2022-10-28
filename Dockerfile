FROM python:3.9-slim-buster
LABEL author="Onalerona"

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Install security updates:
RUN apt-get update && apt-get -y upgrade

WORKDIR /home/appuser

COPY requirements.txt /home/appuser
RUN pip install -r requirements.txt

# Run as non-root user:
RUN useradd --create-home appuser
USER appuser

COPY . /home/appuser

ENTRYPOINT [ "python" ]
CMD ["mysite/manage.py", "runserver", "0.0.0.0:8000"]