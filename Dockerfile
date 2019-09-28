# Python support can be specified down to the minor or micro version
# (e.g. 3.6 or 3.6.3).
# OS Support also exists for jessie & stretch (slim and full).
# See https://hub.docker.com/r/library/python/ for all supported Python
# tags from Docker Hub.
FROM python:alpine
MAINTAINER Pappu_Yadav
# If you prefer miniconda:
#FROM continuumio/miniconda3



LABEL Name=the_weather Version=0.0.1
EXPOSE 8000

WORKDIR /app
ADD . /app
COPY . /app/
COPY requirements.txt ./
# Using pip:
RUN python3 -m pip install -r requirements.txt
CMD ["python3", "-m", "the_weather"]

EXPOSE 8000
#CMD exec gunicorn your_site_name.wsgi:application --bind 0.0.0.0:8000 --workers 3

# Using pipenv:
#RUN python3 -m pip install pipenv
#RUN pipenv install --ignore-pipfile
#CMD ["pipenv", "run", "python3", "-m", "the_weather"]

# Using miniconda (make sure to replace 'myenv' w/ your environment name):
#RUN conda env create -f environment.yml
#CMD /bin/bash -c "source activate myenv && python3 -m the_weather"
# FROM python:3.7
# MAINTAINER your_name
# ADD . /usr/src/app
# WORKDIR /usr/src/app
# COPY requirements.txt ./
# RUN pip install --no-cache-dir -r requirements.txt
# EXPOSE 8000
# CMD exec gunicorn your_site_name.wsgi:application --bind 0.0.0.0:8000 --workers 3