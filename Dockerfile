FROM golang:1.21-alpine

WORKDIR /app

COPY go.mod ./
COPY go.sum ./
RUN go mod download

COPY . .

RUN go build -o monitoring-service

EXPOSE 3024

CMD ["./monitoring-service"]
