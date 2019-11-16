# Nginx web-server

Simple web server that hosts 1 static page (`index.html`) and also interacts and pulls data from the tiny back-end application

## How the front end works

### Dockerfile 

the Dockerfile specifies a [container](https://www.docker.com/resources/what-container) to be built, open `Dockerfile` and follow the explanation below

   1. `nginx:latest` is used as a base container, and sets up a web server with a default configuration.
   1. `RUN rm ...` deletes the default configuration from the nginx server
   1. `COPY nginx.conf` copies our configuration to a default location that the web server can understand
   1. `COPY . /data/` copies all the files from the `front_end/` folder to the `data/` directory in the container so that it can be served when the web server points to the `index.html` in that folder (the default filename for a static webpage)

### index.html 

this is about the smallest example of a full webpage you can create, and you can find many similar examples online. 

   1. `< link...` specifies the stylesheet, allowing us to use `styles.css` to change the style of our static web page. 
   1. `<h1>` section specifies a header
   1. `<p>` section specifies a paragraph
   1. look online for a verbose explanation of this file

### styles.css

this file lets you change the style of your webpage. note that we are changing the look of our paragraphs (`p`) and headers (`h1`) that we created in `index.html`

### nginx.conf

This is the configuration for our web server

1. `upstream` allows us to create an alias name for our back-end server and resolve its name when we forward a request to it. If you specify 2 docker containers in a docker-compose file (see `docker-compose.yml` in the top of this repo) it will put them in the same network, and you can resolve thier ip-address by their `container_name`, so we don't need an IP address here, just the `container_name:<port>` that we're using for our back end.
1. The `server {}` listening on port 80 will forward requests from localhost:80 to the `/data` folder. Remeber, that's where we copied our static web page to in the dockerfile! This request should display our `index.html`!
1. The `server {}` listening on port 8080 will forward requests from localhost:8080 to our backend. Or, put another way, it will simply route our request as a proxy to `http://<ip of our backend>:5000`
