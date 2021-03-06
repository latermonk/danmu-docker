FROM       ubuntu:18.04
#MAINTAINER Aleksandar Diklic "https://github.com/rastasheep"

RUN apt-get update

RUN apt-get install -y openssh-server git wget
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

RUN mkdir /root/.ssh

RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]

RUN wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN source ~/.bashrc  
CMD ["/bin/bash", "nvm install node","--silent"]
RUN git clone https://github.com/liu946/danmuSlideServer.git
RUN cd danmuSlideServer
CMD ["/bin/bash", "npm install"]


#RUN npm install pm2 -g
EXPOSE 3000
CMD ["node", "index.js"]
#MD ["pm2-runtime", "index.js"]
