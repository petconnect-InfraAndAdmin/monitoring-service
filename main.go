package main

import (
	"fmt"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/prometheus/client_golang/prometheus"
	"github.com/prometheus/client_golang/prometheus/promhttp"
)

var (
	requestCount = prometheus.NewCounter(
		prometheus.CounterOpts{
			Name: "monitoring_requests_total",
			Help: "Número total de peticiones recibidas",
		},
	)
)

func init() {
	prometheus.MustRegister(requestCount)
}

func main() {
	port := getPort()

	http.HandleFunc("/health", func(w http.ResponseWriter, r *http.Request) {
		requestCount.Inc()
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "✅ Monitoring Service is healthy")
	})

	http.HandleFunc("/status", func(w http.ResponseWriter, r *http.Request) {
		requestCount.Inc()
		w.WriteHeader(http.StatusOK)
		fmt.Fprintf(w, "🩺 PetConnect Monitoring Service - %s", time.Now())
	})

	http.Handle("/metrics", promhttp.Handler())

	log.Printf("🚀 Monitoring Service running on port %s", port)
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

func getPort() string {
	port := os.Getenv("PORT")
	if port == "" {
		port = "3024"
	}
	return port
}
