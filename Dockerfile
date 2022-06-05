FROM golang:alpine3.16 AS builder

WORKDIR /usr/src/
COPY . .
RUN go mod init hello
RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -a -installsuffix cgo -o app .

#############################################

FROM scratch

WORKDIR /
COPY --from=builder /usr/src/app /
CMD [ "/app" ]