FROM golang:1.16-alpine AS build_base

RUN apk add --no-cache git
WORKDIR /tmp/hotrod

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY . .

RUN go build -o ./bin/hotrod .

FROM alpine:3.9
RUN apk add ca-certificates

COPY --from=build_base /tmp/hotrod/bin/hotrod /hotrod

EXPOSE 8080 8081 8082 8083 6060

ENTRYPOINT ["/hotrod"]
CMD ["all"]
