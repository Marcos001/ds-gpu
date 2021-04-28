FROM tensorflow/tensorflow:latest-gpu-jupyter

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN apt-get update -qq && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    apt-transport-https \
    build-essential \
    libgl1-mesa-glx

COPY ["requirements.txt", "/home/requirements.txt"]

WORKDIR /home

RUN pip install --upgrade --no-cache-dir pip \
    && pip install --no-cache-dir wheel \
    && pip install --no-cache-dir --use-feature=2020-resolver -r requirements.txt \
    && rm -f requirements.txt

CMD ["python3"]
