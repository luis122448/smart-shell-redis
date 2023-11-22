![Logo del Projecto](./resources/logo.png)

# Despliegue Automatizado de Base de Datos Redis con Docker

Este repositorio tiene como objetivo automatizar el despliegue de una base de datos Redis en un contenedor de Docker, proporcionando una solución de caché para una aplicación de red.
  
## Uso

1. **Clonación del Repositorio:**
    ```bash
        git clone https://github.com/luis122448/smart-shell-postgres.git
    ```

2. **Modificación del Archivo de Configuración:**
    ```bash
        cd smart-shell-redis
        nano docker-compose.yml
    ```
    Modificar la contraseña y la memoria máxima de la base de datos Redis.
    ```yml
        ommand: redis-server --requirepass mysecurepassword --maxmemory 1gb --maxmemory-policy volatile-lru
    ```

3. **Creación de la Red:**
    ```bash
        docker network create smart-shell-net
    ```

4. **Creación de la Imagen:**
    ```bash
        cd smart-shell-postgres
        docker build -t smart-shell-postgres .
    ```

5. **Despliegue de la Base de Datos:**
    ```bash
        cd smart-shell-postgres
        docker-compose up -d
    ```

6. **Conexion a la Base de Datos.**
    ```bash
        docker exec -it postgres-smart-shell bash
    ```

7. **Verificando las versiones.**
    ```bash
        psql --version
        postgres --version
    ```

8. **Ingresando con el usuario condigurado**
    ```bash
        psql -U <usuario> --password --db smart-shell
        <password>

        SET search_path TO SMARTSHELL;

        SELECT * FROM TBL_ARTICLE;
    ```

## Contribuciones
Las contribuciones son bienvenidas. Siéntete libre de mejorar este proyecto, agregar nuevas características o corregir problemas identificados. Para contribuir, crea un Pull Request o abre un Issue.

## Licencia
Este proyecto está bajo la licencia MIT License.