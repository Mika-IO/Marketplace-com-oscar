FROM ubuntu:20.04

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y software-properties-common

# deadsnakes ppa for modern python versions
RUN add-apt-repository ppa:deadsnakes/ppa && apt-get update

# install db dependencies
RUN apt-get install -y wget sudo curl \
    python python-dev python3-pip \
    python3.8 python3.8-dev \
    postgresql-client-common libpq-dev \
    postgresql postgresql-contrib postgis \
    libmemcached11 libmemcachedutil2 libmemcached-dev libz-dev memcached \
    libproj-dev libfreexl-dev libgdal-dev gdal-bin  --fix-missing

RUN locale-gen pt_BR.UTF-8
 
# entrypoint
COPY django-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/django-entrypoint.sh
ENTRYPOINT ["django-entrypoint.sh"]

# my project files
COPY requirements.txt ./
RUN pip3 install --upgrade pip
RUN pip3 install --no-cache-dir -r requirements.txt
WORKDIR /usr/src/app/backups
RUN mkdir backups
EXPOSE 8000
COPY src/ ./
COPY Makefile ./

# command of container
CMD make runserver
