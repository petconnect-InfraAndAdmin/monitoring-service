
FROM golang:1.22 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

# Compilación estática para Alpine
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o monitoring-service

# Etapa 2: contenedor final liviano
FROM alpine:3.18

RUN apk --no-cache add ca-certificates

WORKDIR /app

COPY --from=builder /app/monitoring-service .

# Asegurarse que el binario tenga permisos de ejecución
RUN chmod +x ./monitoring-service

EXPOSE 3024

CMD ["./monitoring-service"]
