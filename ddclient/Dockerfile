#FROM jerep6/debian-base
FROM  localhost:5000/debian-base
MAINTAINER jerep6

# Install ddclient
RUN apt-get install --no-install-recommends -y ddclient

# Interval of check = 600 secondes
RUN sed -i 's/daemon_interval=*$/daemon_interval=600/g' /etc/default/ddclient


#Generate configuration for supervisor
RUN echo "\
[supervisord]\n\
nodaemon=true\n\
\
[program:ddclient]\n\
command=/etc/init.d/ddclient start\n\
" > /etc/supervisor/conf.d/config.conf

# Run ddclient on startup
CMD ["/usr/bin/supervisord"]
