FROM ubuntu:24.04

RUN apt-get update \
  && apt-get install -y --no-install-recommends curl unzip ca-certificates telnet \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /pharo

ARG PHARO_VERSION=120
RUN curl -fsSL https://get.pharo.org/64/${PHARO_VERSION}+vm | bash

COPY deps.st ./
RUN ./pharo Pharo.image st --save --quit deps.st

COPY build.st ./
ADD https://api.github.com/repos/Gotchas99/HL7/git/refs/heads/main /tmp/hl7-ref.json
RUN ./pharo Pharo.image st --save --quit build.st

COPY run.st ./

EXPOSE 1701 4999 8080

CMD ["./pharo", "Pharo.image", "st", "run.st"]
