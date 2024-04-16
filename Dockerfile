RUN apt-get install -y python3.6
RUN apt-get install -y pip
    

WORKDIR /Deskop

RUN git clone https://github.com/vyahello/snakegame-gui.git

WORKDIR ./snakegame-gui

RUN pip install -r requirements.txt 

CMD ["pytest", "-s", "-v"]
