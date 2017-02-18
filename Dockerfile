FROM phusion/baseimage:latest

MAINTAINER alexus@gmail.com

RUN apt-get update && apt-get upgrade -y -o Dpkg::Options::="--force-confold"
RUN apt-get install wget

# Repositories for APT and YUM | Beats Platform Reference [5.2] | Elastic
# https://www.elastic.co/guide/en/beats/libbeat/current/setup-repositories.html

RUN wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN apt-get install apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
RUN apt-get update && apt-get install filebeat
RUN update-rc.d filebeat defaults 95 10

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
