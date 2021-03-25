FROM python:3.7.0

RUN apt-get update
RUN apt install software-properties-common -y 
RUN add-apt-repository ppa:deadsnakes/ppa
# RUN apt install python3.7 -y
RUN python -m pip install --upgrade pip
RUN pip3 install virtualenv
ENV VIRTUAL_ENV = /venv
RUN virtualenv venv -p python3
ENV PATH = "$VIRTUAL_ENV/bin:$PATH"

RUN pip3 install --upgrade cython 
RUN pip3 install pyarrow
RUN pip3 install torch==1.7.1+cu101 torchvision==0.8.2+cu101 torchaudio==0.7.2 -f https://download.pytorch.org/whl/torch_stable.html
COPY . /app/
WORKDIR /app
RUN python3 -m pip install -r requirements.txt
EXPOSE 3000
CMD streamlit run main.py --server.port 3000  --server.enableWebsocketCompression=false


