# A Deluge daemon installation
#   with my preffered mount to the outside world
#   (Because my downloads are not container/able)

FROM ubuntu
MAINTAINER Sjoerd <sdevries@gmail.com>

# Adding sources
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

# No idea 
VOLUME ["/mnt/synoVideos"]


## Building ##
# sudo docker -H=tcp://localhost build -t Deluge .

## Running ##
# sudo docker -H=tcp://localhost run -d -v /mnt/synoVideos:/mnt/synoVideos -p 80:8112

### TODO ###
# git clone a known config
# check for more needed ports (sharing anyone)
