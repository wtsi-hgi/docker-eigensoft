FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
         make \
         git \
         ca-certificates \
         gcc \
         build-essential \
         gfortran \
         libgsl0-dev \
         libopenblas-base \
         libopenblas-dev \
         liblapacke-dev \
    && rm -rf /var/lib/apt/lists/*

RUN git clone --depth 1 --branch "v6.1.3" https://github.com/DReichLab/EIG /tmp/EIG
WORKDIR /tmp/EIG/src
ADD Makefile.patch Makefile.patch
RUN patch < Makefile.patch
RUN make clobber OPENBLAS=/opt/openblas && make install OPENBLAS=/opt/openblas
