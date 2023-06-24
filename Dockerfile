# based on Ubuntu 12.04 LTS Precise Pangolin
FROM docker.io/ubuntu:precise

# replace package repository URLs with archived repos (https://askubuntu.com/a/91821)
RUN sed -i -re 's/([a-z]{2}\.)?archive.ubuntu.com|security.ubuntu.com/old-releases.ubuntu.com/g' /etc/apt/sources.list

# get as up to date as we can
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get upgrade -y && apt-get autoremove -y
RUN apt-get install -y libtesseract-dev tesseract-ocr-eng build-essential cmake pkg-config

# get libtiff5-dev and its dependencies' packages that are not in the 'precise' repos from Ubuntu 14.04 Trusty Tahr
ADD http://security.ubuntu.com/ubuntu/pool/main/j/jbigkit/libjbig0_2.0-2ubuntu4_amd64.deb /src/libjbig0.deb
RUN dpkg -i /src/libjbig0.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/x/xz-utils/liblzma5_5.1.1alpha+20120614-2ubuntu2_amd64.deb /src/liblzma5.deb
RUN dpkg -i /src/liblzma5.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/t/tiff/libtiff5_4.0.3-7_amd64.deb /src/libtiff5.deb
RUN dpkg -i /src/libtiff5.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/t/tiff/libtiffxx5_4.0.3-7_amd64.deb /src/libtiffxx5.deb
RUN dpkg -i /src/libtiffxx5.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/z/zlib/zlib1g_1.2.8.dfsg-1ubuntu1_amd64.deb /src/zlib1g.deb
RUN dpkg -i /src/zlib1g.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/z/zlib/zlib1g-dev_1.2.8.dfsg-1ubuntu1_amd64.deb /src/zlib1g-dev.deb
RUN dpkg -i /src/zlib1g-dev.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8_1.3.0-0ubuntu2_amd64.deb /src/libjpeg-turbo8.deb
RUN dpkg -i /src/libjpeg-turbo8.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg-turbo/libjpeg-turbo8-dev_1.3.0-0ubuntu2_amd64.deb /src/libjpeg-turbo8-dev.deb
RUN dpkg -i /src/libjpeg-turbo8-dev.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg8_8c-2ubuntu8_amd64.deb /src/libjpeg8.deb
RUN dpkg -i /src/libjpeg8.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg8-dev_8c-2ubuntu8_amd64.deb /src/libjpeg8-dev.deb
RUN dpkg -i /src/libjpeg8-dev.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/libj/libjpeg8-empty/libjpeg-dev_8c-2ubuntu8_amd64.deb /src/libjpeg-dev.deb
RUN dpkg -i /src/libjpeg-dev.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/j/jbigkit/libjbig-dev_2.0-2ubuntu4_amd64.deb /src/libjbig-dev.deb
RUN dpkg -i /src/libjbig-dev.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/x/xz-utils/liblzma-dev_5.1.1alpha+20120614-2ubuntu2_amd64.deb /src/liblzma-dev.deb
RUN dpkg -i /src/liblzma-dev.deb
ADD http://security.ubuntu.com/ubuntu/pool/main/t/tiff/libtiff5-dev_4.0.3-7_amd64.deb /src/libtiff5-dev.deb
RUN dpkg -i /src/libtiff5-dev.deb
RUN apt-get install -f # fix dependencies if need be

# setup build env
ADD https://github.com/ruediger/VobSub2SRT/archive/refs/tags/v1.0pre7.tar.gz /src/release.tar.gz
WORKDIR /src
RUN tar -zxvf /src/release.tar.gz
WORKDIR /src/VobSub2SRT-1.0pre7
RUN ./configure
RUN make
RUN make install

# prepare userspace
RUN rm -rf /src
WORKDIR /workspace
