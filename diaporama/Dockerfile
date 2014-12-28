#FROM jerep6/debian-base
FROM  localhost:5000/debian-base
MAINTAINER jerep6

# Install mysql, apache, php
RUN apt-get install --no-install-recommends -y php5 apache2 mysql-server php5-mysql php5-gd phpmyadmin \
&& apt-get clean

# Apache : add configuration for virtualhost
ADD diaporama.conf /etc/apache2/sites-available/diaporama.conf
# Apache : activate modules and sites
RUN a2enmod userdir && a2enmod rewrite\
&& a2dissite default\
&& a2ensite diaporama.conf

RUN mkdir -p /app/www/Diaporama/DiaporamaAcimflo && echo "<?php echo 'It\'s working'; ?>" > /app/www/Diaporama/DiaporamaAcimflo/index.php

# PHP : configuration
RUN sed -i -e"s/^max_execution_time =.*/max_execution_time = 60/" /etc/mysql/my.cnf\
&& sed -i -e"s/^max_input_time =.*/max_input_time = 60/" /etc/mysql/my.cnf

#Generate configuration for supervisor
RUN echo "\
[supervisord]\n\
nodaemon=true\n\
\
[program:ddclient]\n\
command=/etc/init.d/ddclient start\n\
" > /etc/supervisor/conf.d/config.conf


EXPOSE 80
VOLUME /app/www/

# Run ddclient on startup
#CMD ["/usr/bin/supervisord"]
