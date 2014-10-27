FROM debian:wheezy
MAINTAINER jerep6

# MAJ des paquets
RUN apt-get update

# Install packages
RUN apt-get install --no-install-recommends -y wget curl ca-certificates less procps vim 

# Install rsync and ssh (for rsync over ssh)
RUN apt-get install --no-install-recommends -y rsync openssh-server

# Configure rsync
RUN sed -i 's/RSYNC_ENABLE=.*$/RSYNC_ENABLE=true/g' /etc/default/rsync
ADD rsyncd.conf /etc/
ADD rsyncd.secrets /etc/
EXPOSE 873

# Create user in order to don't write with root user in volume data
# Assume that uid and guid of user on host is 1000
RUN groupadd -g1000 system \
&& useradd -g1000 -u1000 -m -s /bin/bash system

# Disable password authentification
RUN sed -i 's/#PasswordAuthentication.*$/PasswordAuthentication no/g' /etc/ssh/sshd_config

CMD /etc/init.d/rsync start \
&& /etc/init.d/ssh start \
&& read -p "wait" w
