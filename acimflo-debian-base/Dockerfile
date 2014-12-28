FROM debian:wheezy
MAINTAINER jerep6

# MAJ des paquets
RUN apt-get update

# Install core packages
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get install --no-install-recommends -y wget curl ca-certificates less procps vim supervisor \
&& apt-get clean

