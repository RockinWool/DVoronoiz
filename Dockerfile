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

#---3. コンテナのListen port numberを8888番portとする---# 
EXPOSE 8888
ENV DISPLAY='172.17.0.1:0'

#---4.jupyter-labの立ち上げ設定。この部分は https://qiita.com/komiya_____/items/96c14485eb035701e218 を参考/引用元としている
# ENTRYPOINT命令はコンテナ起動時に実行するコマンドを指定（基本docker runの時に上書きしないもの）
# "jupyter-lab" => jupyter-lab立ち上げコマンド
# "--ip=0.0.0.0" => ip制限なし
# "--port=8888" => EXPOSE命令で書いたポート番号と合わせる
# ”--no-browser” => ブラウザを立ち上げない。コンテナ側にはブラウザがないので 。
# "--allow-root" => rootユーザーの許可。セキュリティ的には良くないので、自分で使うときだけ。
# "--NotebookApp.token=''" => トークンなしで起動許可。これもセキュリティ的には良くない。
ENTRYPOINT ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root", "--NotebookApp.token=''"]

#---5. プログラムをコンテナ内に移動する----#
COPY ./ $HOME/
# CMD命令はコンテナ起動時に実行するコマンドを指定（docker runの時に上書きする可能性のあるもの）
# "--notebook-dir=/workdir" => Jupyter Labのルートとなるディレクトリを指定
CMD [ "--notebook-dir=." ]