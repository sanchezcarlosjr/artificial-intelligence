FROM golang:1.14-buster AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM continuumio/miniconda3:4.12.0

RUN apt-get update -y && \
    DEBIAN_FRONTEND="noninteractive" apt-get -y install tzdata

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tigervnc-standalone-server supervisor gosu && \
    rm -rf /var/lib/apt/lists && \
    mkdir -p /usr/share/desktop-directories

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY menu.xml /etc/xdg/openbox/
COPY supervisord.conf /etc/
EXPOSE 8080

RUN groupadd --gid 1000 app && \
    useradd --home-dir /src --shell /bin/bash --uid 1000 --gid 1000 app && \
    mkdir -p /src

VOLUME /src
WORKDIR /src
RUN . /root/.bashrc && \
    conda init bash && \
    conda create -n cs188 python=3.6 && \
    conda activate cs188

CMD ["sh", "-c", "chown app:app /src /dev/stdout && exec gosu app supervisord"]

