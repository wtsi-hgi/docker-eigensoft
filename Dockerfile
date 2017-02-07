FROM ubuntu:16.04

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install --no-install-recommends -y vim less make git ca-certificates gcc build-essential gfortran libgsl0-dev libopenblas-base libopenblas-dev liblapacke-dev

#RUN git clone --depth 1 --branch master https://github.com/xianyi/OpenBLAS /tmp/OpenBLAS
#WORKDIR /tmp/OpenBLAS
#RUN make FC=gfortran && make install PREFIX=/opt/openblas 

RUN git clone --depth 1 --branch master https://github.com/DReichLab/EIG /tmp/EIG
WORKDIR /tmp/EIG/src
ADD Makefile.patch Makefile.patch
RUN patch < Makefile.patch
RUN make clobber OPENBLAS=/opt/openblas && make install OPENBLAS=/opt/openblas


