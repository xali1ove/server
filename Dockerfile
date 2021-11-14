FROM debian:buster

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install -y vim
RUN apt-get install -y nginx 
RUN apt-get install -y wget 

RUN apt-get -y install mariadb-server
RUN apt-get -y install php-mysql php-fpm php-mbstring php-xml
RUN mkdir /var/www/localhost
COPY ./srcs/nginx.conf /etc/nginx/sites-available/nginx.conf
RUN rm -rf /etc/nginx/sites-enabled/default
RUN ln -s /etc/nginx/sites-available/nginx.conf /etc/nginx/sites-enabled/nginx.conf 

COPY ./srcs/phpMyAdmin-5.1.0-all-languages.tar.gz ./phpMyAdmin-5.1.0-all-languages.tar.gz
RUN tar xvf phpMyAdmin-5.1.0-all-languages.tar.gz  
RUN mv phpMyAdmin-5.1.0-all-languages /var/www/localhost/phpmyadmin
RUN rm -rf phpMyAdmin-5.1.0-all-languages.tar.gz

COPY ./srcs/wordpress-5.6.2-ru_RU.tar.gz ./wordpress-5.6.2-ru_RU.tar.gz
RUN tar xvf wordpress-5.6.2-ru_RU.tar.gz && rm -rf wordpress-5.6.2-ru_RU.tar.gz
RUN mv wordpress /var/www/localhost/wordpress

RUN chown -R www-data var/www/*
RUN chmod -R 755 /var/www/*
COPY ./srcs/init.sh ./
RUN openssl req -x509 -nodes -days 365 -subj "/C=KR/ST=Afganistan/L=Kabul/O=innoaca/OU=42seoul/CN=forhjy" -newkey rsa:2048 -keyout /etc/ssl/nginx-selfsigned.key -out /etc/ssl/nginx-selfsigned.crt;
RUN pwd
COPY srcs/config.inc.php .
EXPOSE 443:443 80:80
CMD bash ../init.sh