FROM python:3.10

WORKDIR ./app

RUN git clone https://github.com/vyahello/snakegame-gui.git

WORKDIR ./snakegame-gui

RUN pip install -r requirements.txt
