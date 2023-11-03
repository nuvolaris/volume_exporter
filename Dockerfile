FROM golang:1.18
LABEL maintainer="Mohammad Nadeem<coolmind182006@gmail.com>"

# PROMU
RUN mkdir /tmp/promu
RUN VER="0.15.0" ;\
    ARCH="$(dpkg --print-architecture)" ;\
    KURL="https://github.com/prometheus/promu/releases/download/v$VER/promu-$VER.linux-$ARCH.tar.gz" ;\
    TMPDIR="promu-$VER.linux-$ARCH" ;\
    curl -sL $KURL | tar xzvf - -C /tmp/promu ;\
    cp /tmp/promu/$TMPDIR/promu /usr/bin/promu

RUN rm -Rf /tmp/promu    

WORKDIR /home/volume_exporter
ADD disk/*.go /home/volume_exporter/disk/
ADD exporter/*.go /home/volume_exporter/exporter/
ADD go.mod /home/volume_exporter/
ADD go.sum /home/volume_exporter/
ADD main.go /home/volume_exporter/
ADD Makefile /home/volume_exporter/
ADD .promu.yml /home/volume_exporter/
ADD .travis.yml /home/volume_exporter/

RUN /usr/bin/promu build --prefix .
RUN cp ./volume_exporter /bin/volume_exporter

USER 1001

ENTRYPOINT [ "/bin/volume_exporter" ]
CMD        [ "--volume-dir=bin:/bin", \
             "--web.listen-address=:9888" ]
