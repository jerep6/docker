FROM  localhost:5000/debian-base
MAINTAINER jerep6

# Install rsync and ssh (for rsync over ssh)
RUN apt-get install --no-install-recommends -y rsync openssh-server

# RSYNC : configure
RUN sed -i 's/RSYNC_ENABLE=.*$/RSYNC_ENABLE=true/g' /etc/default/rsync

# Create user in order to don't write with root user in volume data
# Assume that uid and guid of user on host is 1000
RUN groupadd -g1000 system \
&& useradd -g1000 -u1000 -m -s /bin/bash system

# SSH : Disable password authentification
RUN sed -i 's/#PasswordAuthentication.*$/PasswordAuthentication no/g' /etc/ssh/sshd_config



#Generate configuration for supervisor
RUN echo "\
[supervisord]\n\
nodaemon=true\n\
\
[program:rsync]\n\
command=/etc/init.d/rsync start\n\
\
[program:ssh]\n\
command=/etc/init.d/ssh start\n\
" > /etc/supervisor/conf.d/config.conf


VOLUME /data
VOLUME /data_crypt
EXPOSE 22
EXPOSE 873

# Run supervisord on startup
CMD ["/usr/bin/supervisord"]


#CMD /etc/init.d/rsync start \
#&& /etc/init.d/ssh start \
#&& read -p "wait" w
