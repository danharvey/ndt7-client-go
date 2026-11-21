FROM golang:1.25-alpine3.24 AS ndt7-prometheus-exporter-build
WORKDIR /go/src/github.com/m-lab/ndt7-client
ADD . ./
RUN go get ./cmd/ndt7-prometheus-exporter
RUN go build ./cmd/ndt7-prometheus-exporter

FROM alpine:3.24
WORKDIR /app
COPY --from=ndt7-prometheus-exporter-build /go/src/github.com/m-lab/ndt7-client/ndt7-prometheus-exporter ./
EXPOSE 8080
ENTRYPOINT ["./ndt7-prometheus-exporter", "--port=8080"]
