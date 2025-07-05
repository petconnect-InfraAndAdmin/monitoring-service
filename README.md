# Monitoring Service – PetConnect

Este microservicio ofrece endpoints básicos de monitoreo y métricas Prometheus.

## Endpoints

| Ruta      | Método | Descripción                         |
|-----------|--------|-------------------------------------|
| /health   | GET    | Revisa si el servicio está activo   |
| /status   | GET    | Muestra info básica con timestamp   |
| /metrics  | GET    | Exposición Prometheus               |

## Uso

```bash
curl http://localhost:3024/health
curl http://localhost:3024/metrics
