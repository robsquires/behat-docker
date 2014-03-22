FROM ubuntu:precise

RUN apt-get update


RUN apt-get install -y python-software-properties && \
  apt-add-repository -y ppa:ondrej/php5 && \
  apt-get update

RUN apt-get -y install php5-cli php5-gearman


WORKDIR /var/www
