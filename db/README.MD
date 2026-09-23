## Postgress

### Despliegue en Docker 


```bash
cd db
docker compose up -d
```

### Despliegue en Kubernetes 

```bash
kubectl apply -f db/postgres.yaml
```