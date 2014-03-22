FROM darh/php-essentials

RUN apt-get -y install php5-gearman

WORKDIR /var/www

ADD ./ /var/www