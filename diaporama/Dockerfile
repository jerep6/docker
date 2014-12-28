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
&& a2ensite diaporama.conf\
&& echo "Include /etc/phpmyadmin/apache.conf" >> /etc/apache2/apache2.conf

# Create default index.php when no volume is mounted
RUN mkdir -p /app/www/ && echo "<?php echo 'It\'s working'; ?>" > /app/www/index.php



# PHP : configuration
RUN sed -i -e"s/^max_execution_time =.*/max_execution_time = 60/" /etc/php5/apache2/php.ini\
&& sed -i -e"s/^max_input_time =.*/max_input_time = 60/" /etc/php5/apache2/php.ini\
&& sed -i -e"s/^display_errors =.*/display_errors == On/" /etc/php5/apache2/php.ini



# MySQL : change data directory
RUN sed -i -e"s/^datadir.*/datadir  = \/app\/mysql/" /etc/mysql/my.cnf
ADD mysql_change_database_directory.sh /tmp/


#Generate configuration for supervisor
RUN echo "\
[supervisord]\n\
nodaemon=true\n\
\
[program:mysql]\n\
command=/etc/init.d/mysql start\n\
\
[program:apache2]\n\
command=/etc/init.d/apache2 start\n\
" > /etc/supervisor/conf.d/config.conf


EXPOSE 80
VOLUME /app/www/
VOLUME /app/mysql/

# Run apache and mysql on startup
CMD ["/usr/bin/supervisord"]
