from multiprocessing import cpu_count
from os import environ

bind = ":{}".format(environ.get('PORT','5000'))
workers = 4 #cpu_count()
