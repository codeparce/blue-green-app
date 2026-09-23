# 📚 Diccionario de Flags de Trivy

- [Documentacion](https://github.com/aquasecurity/trivy-action) 

```bash
trivy fs -o report --scanners vuln,secret,misconfig -s HIGH,CRITICAL . 
```

Guía rápida de los parámetros y banderas (*flags*) más útiles para configurar y personalizar los escaneos de Trivy.

| Bandera / Flag | Alias | Descripción breve | Ejemplo de uso |
| :--- | :---: | :--- | :--- |
| `--format` | `-f` | Define el formato de salida del reporte (`table`, `json`, `sarif`, `template`). | `trivy fs -f json .` |
| `--scanners` | - | Selecciona qué analizadores ejecutar de forma específica (`vuln`, `secret`, `misconfig`, `license`). | `trivy fs --scanners vuln,secret .` |
| `--severity` | `-s` | Filtra los resultados por nivel de gravedad (`UNKNOWN`, `LOW`, `MEDIUM`, `HIGH`, `CRITICAL`). | `trivy image --severity HIGH,CRITICAL mi-imagen` |
| `--exit-code` | - | Define el código de salida que devolverá el comando si encuentra hallazgos (ideal para pipelines, ej. `1`). | `trivy fs --exit-code 1 .` |
| `--output` | `-o` | Guarda el reporte generado en un archivo físico en lugar de mostrarlo en la terminal. | `trivy fs -o reporte.json .` |
| `--ignore-unfixed` | - | Oculta aquellas vulnerabilidades que todavía no tienen un parche o solución oficial disponible. | `trivy image --ignore-unfixed nginx:latest` |
| `--config` | - | Especifica la ruta de un archivo de configuración personalizado (por defecto busca `trivy.yaml`). | `trivy fs --config custom-trivy.yaml .` |
| `--timeout` | - | Establece el tiempo límite de espera para completar el escaneo (ej. `5m`, `10m`). | `trivy image --timeout 10m mi-imagen` |
| `--skip-dirs` | - | Excluye directorios específicos del análisis de forma separada por comas. | `trivy fs --skip-dirs node_modules,vendor .` |
| `--skip-files` | - | Excluye archivos específicos del análisis de forma separada por comas. | `trivy fs --skip-files secret.txt .` |