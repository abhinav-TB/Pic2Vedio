FROM nvcr.io/nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

RUN apt-get update
RUN apt-get python3.7

COPY . /app/
WORKDIR /app

RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt

RUN streamlit run main.py
FROM nvcr.io/nvidia/cuda:10.1-cudnn7-runtime-ubuntu18.04

RUN apt-get update
RUN apt install software-properties-common -y 
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install python3.7 -y
RUN apt-get install python3-pip -y
RUN pip3 install virtualenv
ENV VIRTUAL_ENV = /venv
RUN virtualenv venv -p python3.7
ENV PATH = "$VIRTUAL_ENV/bin:$PATH"

COPY . /app/
WORKDIR /app

RUN pip3 install Cython
RUN python3.7 -m pip install streamlit==0.78.0
RUN pip3 install torch==1.7.1+cu101 torchvision==0.8.2+cu101 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
RUN python3.7 -m pip install -r requirements.txt


RUN streamlit run main.py
