# Flask-based application

tiny little application that spits out "hello world!" and runs locally. 

Uses gunicorn for the [WSGI](https://en.wikipedia.org/wiki/Web_Server_Gateway_Interface) (pronounced "whiskey")

## How the back end works

### Dockerfile 

specifies a [container](https://www.docker.com/resources/what-container) to be built, open `Dockerfile` and follow the explanation below:

   1. `python:3-alpine` is used as a base container, containing many dependencies you will need to run a lightweight container (alpine) running python
   1. the app will run on port 5000, so we `EXPOSE 5000` NOT so our local machine can access it, but so other containers in the docker network can
   1. `COPY` all files in `back_end/` to `/app` in our container
   1. `WORKDIR` specifies the working directory for the app, which we want to be where we dumped all those files
   1. `RUN pip...` installs dependencies for our application using the python package installer `pip`
   1. `ENTRYPOINT` specifies the application that is the entrypoint for our service. In this case, we are using gunicorn as the WSGI for our python application, so that's our entrypoint
   1. `CMD` feeds in commands to our entrypoint
      1. `--config` points to the gunicorn configuration
      1. `wsgi:app` says to run `app` in the `wsgi.py` file
   
### requirements.txt

These are the python libraries we need to install with version numbers we will use these in our app

### app.py

This is a simple python script that uses flask to create a little app. There's actually quite a lot going on here if you've never seen python before. You may need to look at a few resources to understand exactly what's happening, but I'll try to break it down the best I can

1. `from flask...` imports the flask library so we can use the functions defined in it. In python, you have to explicitly include libraries of functions/definitions/methods you want to use. There are sane default libraries that always work, of course. 
1. `app = Flask(__name__)` creates a flask application object. `__name__` in python is a special variable; if you run a file `python app.py` then `__name__` will be the string `__main__`. However, if app.py is called from another python file, then __name__ will be the name of the library that they install to access app.py.
1. `@app.route('/')` is a decorator. Decorators are a whole rabbit-hole to go down, but essentially, when I'm calling my application (`<app ip address>/`) navigating to this path will call this function. 
1. `if ...` lets you run the app by calling app.py directly, but we won't be using that

### config.py

This is a simple python script that sets up gunicorn (the wsgi that will be serving our app). Note the 4 workers and that we're binding to port 5000

### wsgi.py

When we call `gunicorn <...> wsgi:app` in our dockerfile this is the file we're referencing. Note that this imports our app called "app", and then our app is running because of the `app.run()` command. Gunicorn is simply the middle-man between our python application and our web server.

