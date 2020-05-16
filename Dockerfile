#image de base
FROM debian:buster


#maintenance Dockerfile
LABEL mainainter="frchaban <frchaban@student.42.fr>"

#update
RUN apt-get update
RUN apt-get upgrade -y

#install tools
RUN apt-get -y install wget

#install nginx
RUN apt-get -y install nginx

#install PHP
RUN apt-get -y install php7.3 php-mysql php-fpm php-cli php-mbstring

#install mySQL
RUN apt-get -y install mariadb-server

#Copy sources
COPY ./srcs/initialisation.sh ./
COPY ./srcs/nginx.conf	./etc/nginx/sites-available/localhost
COPY ./srcs/config.inc.php ./
COPY ./srcs/wp-config.php ./
COPY ./srcs/wordpress.sql ./var/

#lauch initialisation
RUN chmod 755 ./initialisation.sh
CMD bash ./initialisation.sh

#ouvrir ports
EXPOSE 80 443

#variable env
ENV INDEX_AUTO=on
#docker run -tid -p 80:80 -p 443:443 --name NAME IMAGE (-e INDEX_AUTO=0 if you want to desactivate index auto)
