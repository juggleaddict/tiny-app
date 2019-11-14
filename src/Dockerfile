FROM python:latest
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y python3 python3-pip 
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt
ENTRYPOINT ["gunicorn"]
CMD ["--config","config.py","wsgi:app"]