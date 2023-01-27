FROM ubuntu
RUN apt-get update \
  &&  apt-get install -y make \
  &&  apt-get install -y build-essential \
  &&  apt-get install -y wget \
  &&  apt-get install -y git 
COPY ./go /usr/local/go
COPY  ./prom2tower /usr/local/prom2tower
COPY ./config.yaml /usr/local/etc/
ENV PATH="${PATH}:/usr/local/go/bin"
RUN /bin/bash -c 'source $HOME/.profile; echo $HOME'
RUN /bin/bash -c 'go version; echo $HOME'
WORKDIR /usr/local/prom2tower
RUN /bin/sh -c 'make; echo $HOME'
WORKDIR /usr/local/prom2tower/
EXPOSE 9999
CMD [ "./prom2tower", "-c","/usr/local/etc/config.yaml" ] 
