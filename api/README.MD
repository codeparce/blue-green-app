## API 

Para ejecutar la API directamente con `pnpm`, inicia PostgreSQL y ejecuta:

```bash
cd api
pnpm install
pnpm dev
```

La API carga las variables de `api/.env` automáticamente. Usa `api/.env.example` como plantilla.

La API quedara disponible en `http://localhost:3000`.

Listar datos:

```bash
curl http://localhost:3000/api/items
```

Insertar un dato:

```bash
curl -X POST http://localhost:3000/api/items \\
	-H 'Content-Type: application/json' \\
	-d '{"name":"Producto demo","descrip":"Ejemplo de registro","monto":99.90}'
```