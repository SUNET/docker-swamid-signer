FROM ubuntu:16.04
MAINTAINER leifj@sunet.se
RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections
RUN apt-get -q update && apt-get -y upgrade && apt-get install -y git wget curl build-essential libdate-calc-perl libxml2-utils xsltproc opensaml2-tools xmlsec1 autoconf python-pip python-dev libxslt-dev zlib1g-dev
WORKDIR /usr/src
RUN git clone git://git.sunet.se/saml-md-tools.git && cd saml-md-tools && /usr/bin/autoreconf -is && ./configure --prefix=/usr/local && make && make install
RUN easy_install --upgrade setuptools
RUN easy_install --upgrade git+git://github.com/leifj/pyXMLSecurity.git#egg=pyXMLSecurity
RUN easy_install --upgrade requests
WORKDIR /opt/swamid-metadata
