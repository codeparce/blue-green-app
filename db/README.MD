## Postgress

Despliegue en Docker 


```bash
cd db
docker compose up -d
```

Despliegue en Kubernetes 

```bash
kubectl apply -f db/postgres.yaml
```

Variables de conexión del API: `DB_HOST`, `DB_PORT`, `DB_NAME`, `DB_USER` y `DB_PASSWORD`. Al ejecutar la imagen, pásalas con `--env-file api/.env`; el archivo no se copia dentro de la imagen.