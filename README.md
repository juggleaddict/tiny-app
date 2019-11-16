# tiny-app

The goal of this project is to create an incredibly small full stack application that acts as a "hello-world" for people looking for context around full-stack applications and how all the pieces fit together. 

The docs are meant to be verbose to catch any mis-understanding from all backgrounds, they may be annoyingly verbose, you have been warned!

## requirements 

* [docker](https://docs.docker.com/v17.09/engine/installation/)
* [docker-compose](https://docs.docker.com/compose/install/)

## usage

1. install the requirements above
1. run `docker-compose up` in a command window
1. nativage to `localhost` in a browser to view the front end static site you will find at `front_end/index.html`
1. navigate to `localhost:8080` in a browser to view raw text grabbed from the backend python-based application at `back_end/app.py`
1. `ctrl+c` in the command window will kill the containers

## concepts

```
           +-------------+
           |    client   |
           +---+-----+---+
               |     |
  localhost:80 |     |  localhost:8080
  request      |     |  request
               |     |
+--------------+-----+-----------------+
|        |nginx web server|            |
|        +-----+-----+----+            |
|              |     |                 |
|              |     +-----+           |  front
|              v           |           |   end
| +------------+---+       |           |
| |/data/index.html|       |           |
| +----------------+       |           |
+--------------------------------------+
                           |
       +-------------------+
       |
       |
+--------------------------------------+
|      |          +------------------+ |
| +----v-----  +->+flask app worker 1| |
| |         |  |  +------------------+ |
| | gunicorn+--+                       | back
| | wsgi    |     +------------------+ | end
| |         +---->+flask app worker 2| |
| +--+----+-+     +------------------+ |
|    |    |                            |
|    |    |       +------------------+ |
|    |    +------>+flask app worker 3| |
|    |            +------------------+ |
|    |                                 |
|    |            +------------------+ |
|    +----------->+flask app worker 4| |
|                 +------------------+ |
+--------------------------------------+
```