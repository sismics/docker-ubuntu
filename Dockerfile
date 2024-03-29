FROM ubuntu:22.04
MAINTAINER Benjamin Gamard <b.gamard@sismics.com>

# Run Debian in non interactive mode
ENV DEBIAN_FRONTEND noninteractive

# Install Sismics repository
RUN apt-get update && apt-get install -y apt-transport-https ca-certificates software-properties-common curl gnupg tzdata
RUN curl -fsSL https://www.sismics.com/pgp | apt-key add -
# RUN add-apt-repository "deb [arch=amd64] https://nexus.sismics.com/repository/apt-bionic/ bionic main"

# Configure settings
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
RUN ln -fs /usr/share/zoneinfo/Europe/Paris /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
COPY etc /etc
RUN echo "for f in \`ls /etc/bashrc.d/*\`; do . \$f; done;" >> ~/.bashrc
RUN apt-get -y -q install vim less procps unzip wget && \
    rm -rf /var/lib/apt/lists/*
