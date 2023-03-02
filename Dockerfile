FROM ubuntu:20.04

RUN apt-get update
RUN apt-get -y upgrade
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN apt-get -y install make git zlib1g-dev libssl-dev gperf php-cli cmake g++
RUN git clone https://github.com/tdlight-team/tdlight.git
RUN cd tdlight \
    && rm -rf build \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local .. \
    && cmake --build . --target install 
WORKDIR /
RUN apt-get -y install wget
RUN wget -c https://dl.google.com/go/go1.19.5.linux-amd64.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go1.19.5.linux-amd64.tar.gz \
    && rm -rf go1.19.5.linux-amd64.tar.gz
RUN echo "export PATH=$PATH:/usr/local/go/bin" >> /root/.bashrc
RUN echo "export HOME=/root" >> ~/.bashrc
RUN echo "ulimit -c 1024" >> ~/.bashrc
RUN export HOME=/root
WORKDIR /root


