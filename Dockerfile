FROM ubuntu:xenial

RUN apt-get update

RUN apt-get install -y build-essential python git wget curl nano make g++

RUN apt-get install -y libboost-all-dev libtag1-dev zlib1g-dev  

RUN mkdir /opt/echoprint && \
	cd /opt/echoprint && \
	git clone --depth=1 https://github.com/spotify/echoprint-codegen.git codegen && \
	git clone --depth=1 https://github.com/spotify/echoprint-server.git server

WORKDIR /opt/echoprint

RUN cd codegen/src && \
	make && \
	mv ../echoprint-codegen /usr/local/bin/echoprint-codegen

RUN cd server && \
	python setup.py install

RUN apt-get install -y python-pip

RUN pip install nose flake8 flask tornado