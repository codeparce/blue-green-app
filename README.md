# Blue-Green App

Aplicacion web estatica usada para demostrar un despliegue blue-green con Nginx.

- `blue/`: version azul de la pagina.
- `green/`: version verde de la pagina.
- Cada version tiene su propio `Dockerfile` y se sirve con Nginx en el puerto 80 del contenedor.

## Requisitos

- Docker instalado y en ejecucion.
- `curl` para las pruebas HTTP opcionales.

## Construir las imagenes

Desde la raiz del repositorio:

```bash
docker build -t blue-green-app:blue ./blue
docker build -t blue-green-app:green ./green
```

Comprobar las imagenes creadas:

```bash
docker images blue-green-app
```

## Probar las imagenes

Levantar la version blue en el puerto `8080`:

```bash
docker run -d --name blue-app -p 8080:80 blue-green-app:blue
curl http://localhost:8080
```

Levantar la version green en el puerto `8081`:

```bash
docker run -d --name green-app -p 8081:80 blue-green-app:green
curl http://localhost:8081
```

Tambien se pueden abrir estas direcciones en el navegador:

- http://localhost:8080 para blue.
- http://localhost:8081 para green.


## Publicar las imagenes

```bash
docker login 

docker tag blue-green-app:blue codeparce/blue-green-app:blue
docker tag blue-green-app:green codeparce/blue-green-app:green

docker push codeparce/blue-green-app:blue 
docker push codeparce/blue-green-app:green 
``` 
