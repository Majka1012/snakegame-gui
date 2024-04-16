FROM python:3 AS builder

WORKDIR /Deskop

RUN git clone https://github.com/vyahello/snakegame-gui.git

WORKDIR ./snakegame-gui

RUN pip install -r requirements.txt 

CMD ["pytest", "-s", "-v"]
