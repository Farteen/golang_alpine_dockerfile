FROM golang:alpine AS builder
ENV GO111MODULE on
ENV GOPROXY https://goproxy.cn

WORKDIR /go/ms
ADD . .
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -a -installsuffix cgo -ldflags="-w -s" -o app
RUN pwd

FROM alpine:latest AS production
WORKDIR /root/
COPY --from=builder /go/ms/app .
EXPOSE 9000
ENTRYPOINT ["./app"]
