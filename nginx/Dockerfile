FROM ubuntu:16.04

MAINTAINER Ignatios Drakoulas <ignatios@drakoulas.gr>

RUN \
  sed -i 's/# \(.*multiverse$\)/\1/g' /etc/apt/sources.list && \
  apt-get update && \
  apt-get -y upgrade && \
  apt-get install -y build-essential && \
  apt-get install -y software-properties-common && \
  apt-get install -y curl git htop man unzip nano wget

RUN echo "deb http://nginx.org/packages/mainline/ubuntu/ xenial nginx" >> /etc/apt/sources.list && \
    echo "deb-src http://nginx.org/packages/mainline/ubuntu/ xenial nginx" >> /etc/apt/sources.list && \
    wget http://nginx.org/keys/nginx_signing.key && \
    apt-key add nginx_signing.key

RUN apt-get update && apt-get install -y nginx && \
  rm -rf /var/lib/apt/lists/*

RUN rm -v /etc/nginx/nginx.conf

COPY nginx.conf /etc/nginx/

EXPOSE 80 443

CMD service nginx start