FROM debian:latest
RUN apt-get update
RUN apt-get -y upgrade
RUN apt-get install -y python3 python3-pip 
COPY . /app
WORKDIR /app
RUN pip3 install -r requirements.txt
ENTRYPOINT ["python3"]
CMD ["src/app.py"]