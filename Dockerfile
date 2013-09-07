# A Deluge daemon installation
#   with my preffered mount to the outside world
#   (Because my downloads are not container/able)

FROM ubuntu
MAINTAINER Sjoerd <sdevries@gmail.com>

# Add source
RUN echo "deb http://archive.ubuntu.com/ubuntu precise main universe" > /etc/apt/sources.list
# And get up to date
RUN apt-get update
RUN apt-get upgrade -y

# Install packages ->
RUN apt-get -y install deluged deluge-web python-setuptools
RUN easy_install supervisor

# Expose our service
EXPOSE 8112

# Add supervisor config
ADD .docker/supervisor.conf /etc/supervisor.conf

# Run our service
CMD ["/usr/local/bin/supervisord", "-c", "/etc/supervisor.conf", "-n"]


###  Persistence  ###
#
# Run docker with -v /mnt/synoVideos:/mnt/synoVideos to have
# our shows mounted inside the container
#
VOLUME ["/mnt/synoVideos"]

