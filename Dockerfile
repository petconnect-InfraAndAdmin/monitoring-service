FROM golang:1.22 AS builder

WORKDIR /app

# Copia archivos para dependencias
#RUN echo "nameserver 8.8.8.8" > /etc/resolv.conf

COPY go.mod go.sum ./
RUN go mod download

# Copia el código fuente
COPY . .

# Compilación estática para Linux AMD64
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o monitoring-service

# Imagen final minimalista
FROM alpine:3.18

RUN apk --no-cache add ca-certificates

WORKDIR /app

# Copia el binario compilado
COPY --from=builder /app/monitoring-service .

# Permisos de ejecución
RUN chmod +x ./monitoring-service

# Puerto a exponer
ENV PORT=3024
EXPOSE 3024

CMD ["./monitoring-service"]
