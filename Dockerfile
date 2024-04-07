FROM golang:1.17.2-alpine AS build-env

RUN apk add git
ADD . /go/src/mgwls
WORKDIR /go/src/mgwls
RUN go build -o mgwls

FROM alpine:3.14
LABEL licenses.mgwls.name="MIT" \
      licenses.mgwls.url="https://github.com/cvedb/mgwls/blob/main/LICENSE" \
      licenses.golang.name="bsd-3-clause" \
      licenses.golang.url="https://go.dev/LICENSE?m=text"

COPY --from=build-env /go/src/mgwls/mgwls /bin/mgwls

RUN mkdir -p /hive/in /hive/out

WORKDIR /app
RUN apk add bash

ENTRYPOINT [ "mgwls" ]