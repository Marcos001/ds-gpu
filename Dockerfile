FROM tensorflow/tensorflow:latest-gpu-jupyter

ARG HOME
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1


RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    build-essential \
    wget \
    curl \
    git \
    cmake \
    texlive-xetex \ 
    libgl1-mesa-glx

WORKDIR ${HOME}

# copy file with packages requeriments
COPY requeriments.txt ${HOME}requeriments.txt

# install pyenv and python
RUN git clone git://github.com/yyuu/pyenv.git .pyenv

ENV PYENV_ROOT ${HOME}/.pyenv
ENV PATH $PYENV_ROOT/shims:$PYENV_ROOT/bin:$PATH

RUN pyenv install 3.8.1
RUN pyenv global 3.8.1
RUN pyenv rehash

# upgrade pip
RUN pip  install --upgrade pip 

## install python packages
RUN pip install -r requeriments.txt

# remove requeriments.txt
RUN rm requeriments.txt

CMD ["python3"]
