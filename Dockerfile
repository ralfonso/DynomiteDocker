##########################################################################
# Dockerfile to build Dynomite container images with Redis as the backend
# Based on Ubuntu
##########################################################################

# Set the base image to Ubuntu
FROM ubuntu

# File Author / Maintainer
MAINTAINER Ioannis Papapanagiotou - Email: ipapapan@purdue.edu

# Update the repository sources list and Install package Build Essential
RUN apt-get update && apt-get install -y \
	autoconf \
	build-essential \
	dh-autoreconf \
	git \
	libssl-dev \
	libtool \
	python-software-properties
#	tcl8.5

#	redis-server \
# Get Redis Running
#RUN service redis-server start

# Clone the Dynomite Git
COPY dynomite /root/dynomite
RUN echo 'Git repo has been copied in your Docker VM'

# Move to working directory
WORKDIR /root/dynomite/
RUN pwd

# Autoreconf
RUN autoreconf -fvi \
	&& ./configure --enable-debug=log \
	&& make
	&& make install

##################### INSTALLATION ENDS #####################
#
#
COPY dynomite.yml /etc/dynomite.yml

# Expose the peer port
RUN echo 'Exposing peer port 8101'
EXPOSE 8101

# Default port to acccess Dynomite
RUN echo 'Exposing client port for Dynomite'
EXPOSE 8102

# Default port to execute the entrypoint (Dynomite)
CMD ["--port 8102"]

# Setting the dynomite as the dockerized entry-point application
RUN echo 'Starting Dynomite'
ENTRYPOINT ["src/dynomite", "--conf-file=/etc/dynomite.yml", "-v6"]

CMD ["run"]


