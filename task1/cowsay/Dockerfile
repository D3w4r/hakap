FROM ubuntu:latest

RUN apt update && \
    apt install -y cowsay

ENV PATH="/usr/games/:${PATH}"

ADD cow_script.sh /root/cow_script.sh
ADD sentences.log /root/sentences.log
ADD index.html /root/shared/index.html

CMD ["/bin/bash", "/root/cow_script.sh"]