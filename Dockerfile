FROM centos:7
MAINTAINER Diego Fernández

# Add epel
RUN yum install -y epel-release

# Install common redborder dependencies
RUN echo '10.0.70.31 rbrepo.redborder.lan' | tee --append /etc/hosts; \
  rpm -ivh http://rbrepo.redborder.lan/redBorder/rbrepo-1.0.0-1.el7.rb.noarch.rpm; \
  yum install -y \
    gcc                 \
    make                \
    tar                 \
    which               \
    wget                \
    lcov                \
    cmake               \
    valgrind            \
    slang-devel         \
    libcmocka-devel;    \
  yum clean all

# Install freeradius dependencies
RUN echo '10.0.70.31 rbrepo.redborder.lan' | tee --append /etc/hosts; \
  yum install -y \
    openssl-devel 	\
    libgcrypt		\
    libtool-ltdl-devel	\
    krb5-devel		\
    zlib		\
    libcurl-devel	\
    slang-devel         \
    librd-devel         \
    rbutils-devel       \
    librdkafka-devel    \
    yajl                \
    yajl-devel          \
    python-setuptools	\
    gcc-c++		\
    automake		\
    git;		\
  yum clean all

# kafkacat:

RUN git clone https://github.com/anarey/kafkacat.git --branch freeradius-docker
WORKDIR /kafkacat
RUN sh ./bootstrap.sh

# Pycheckjson
WORKDIR /pycheckjson
RUN git clone https://github.com/anarey/pycheckjson.git .
RUN python setup.py install

WORKDIR /app
