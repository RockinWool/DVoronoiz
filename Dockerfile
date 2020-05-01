#-------Discription(説明)--------#
#This Dockerfile can make Anaconda(runtime) environment.
# Maintainer is RockinWool
#--------------------------------# 
#----1. Create Anaconda runtime---#
#NOTE! This Anaconda image is always latest version.#
FROM ubuntu:18.04
LABEL author="RockinWool"

#---2. Create Home dir: コンテナ内にhomeディレクトリを作成する#
ENV HOME=/home/RockinWool
RUN mkdir ${HOME}
WORKDIR $HOME

#---3. 環境作成---------#
RUN apt-get -qq update \
    && DEBIAN_FRONTEND=noninteractive apt-get -qq install -y --no-install-recommends \
    python-pygments \
    git \
    ca-certificates \
    asciidoc \
    gedit \
    tig \
    wget \
    xterm \
    && rm -rf /var/lib/apt/lists/*

#----3-2. Anaconda を入れる----------#
ENV PATH /opt/conda/bin:$PATH
RUN wget --quiet https://repo.anaconda.com/archive/Anaconda3-2020.02-Linux-x86_64.sh -O ~/anaconda.sh && \
    /bin/bash ~/anaconda.sh -b -p /opt/conda && \
    rm ~/anaconda.sh && \
    echo "export PATH=/opt/conda/bin:$PATH" >> ~/.bashrc
    
#----4-1. プログラムの投入--------#
COPY ./main.py $HOME/
COPY ./figure_out.py $HOME/
