FROM ubuntu:latest

MAINTAINER alexus@gmail.com

RUN apt-get -qq update
RUN apt-get -qq -y install --no-install-recommends wget apt-utils libterm-readline-gnu-perl

# Repositories for APT and YUM | Beats Platform Reference [5.2] | Elastic
# https://www.elastic.co/guide/en/beats/libbeat/current/setup-repositories.html

RUN wget --no-check-certificate -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | apt-key add -
RUN apt-get -qq -y install apt-transport-https
RUN echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | tee -a /etc/apt/sources.list.d/elastic-5.x.list
RUN apt-get -qq update && apt-get -qq -y install metricbeat
RUN update-rc.d metricbeat defaults 95 10

RUN apt-get autoremove && apt-get autoclean
