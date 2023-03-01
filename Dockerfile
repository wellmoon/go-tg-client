FROM alpine:3.12 as build
RUN apk update
RUN apk upgrade
RUN apk add --update alpine-sdk linux-headers git zlib-dev openssl-dev gperf php cmake
RUN git clone https://github.com/tdlight-team/tdlight.git
WORKDIR tdlight
RUN rm -rf build
RUN mkdir build \
    && cd build \
    && cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local .. \
    && cmake --build . --target prepare_cross_compiling \
    && cd ..
RUN php SplitSource.php \
    && cd build \
    && cmake --build . --target install \
    && cd .. \
    && php SplitSource.php --undo \ 
    && cd ..
# 回到根目录
WORKDIR /
