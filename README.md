![Logo del Projecto](./resources/logo.png)

# Despliegue Automatizado de Base de Datos Redis con Docker

Este repositorio tiene como objetivo automatizar el despliegue de una base de datos Redis en un contenedor de Docker, proporcionando un servidor de caching para el proyecto de Smart-Shell ( Facturador Electronico ) y Platform-Training ( Plataforma de Capacitacion )
  
## Repositorios Relacionados

### Repositorio Actual
- [Smart-Shell-Redis](https://github.com/luis122448/smart-shell-redis)

### Repositorios Relacionados

Repositorios referidos al BACKEND y FRONTEND de la aplicacion Smart-Shell y Platform-Training.
- [Smart-Shell-Angular](https://github.com/luis122448/smart-shell-angular)
- [Smart-Shell-SpringBoot](https://github.com/luis122448/smart-shell-springboot)
- [Platform-Training-Angular](https://github.com/luis122448/platform-training-angular)
- [Platform-Training-SpringBoot](https://github.com/luis122448/platform-training-springboot)

Repositorios relacionado a la automatizacion de despliegue.
- [Smart-Shell-Bash](https://github.com/luis122448/smart-shell-bash)

Repositorios relacionados a otras bases de datos del proyecto Smart-Shell.
- [Smart-Shell-Mongo](https://github.com/luis122448/smart-shell-mongo)
- [Smart-Shell-Postgres](https://github.com/luis122448/smart-shell-postgres)

## Configuracion del Entorno

1. **Clonar el Repositorio**

    ```bash
        git clone https://github.com/luis122448/smart-shell-redis.git
    ```

2. **Ingresar al directorio del proyecto**
        
    ```bash
        cd smart-shell-redis
    ```

3. **Ejecutar el script de instalación**
    
    ```bash
        sudo bash dev-install.sh
    ```

4. **Defina las credenciales en el archivo .env**

    ```bash
        nano .env
    ```
    
    ```bash
        REDIS_PASSWORD=''
    ```

5. **Crear (si no existe) el network**

    ```bash
        docker network create smart-shell-net
    ```
    
## Despliegue en Producción

Para el despliegue en producción se ha utilizado Docker y Docker Compose, puede revisar el archivo docker-compose.yml para conocer los detalles de la configuración.
Asimismo no se olvide de modificar las variables de entono, en asi archivo .env

1. **Ejecutar el script de despliegue**
    
    ```bash
        sudo bash deploy.sh
    ```

## Verificacion del despliegue

1. **Ingresando a los contenedor**

    ```bash
        docker exec -it smart-shell-redis bash
    ```

2. **Conexión a la Base de Datos**

    ```bash
        redis-cli
    ```

3. **Auhenticando**

    ```bash
        AUTH <password>
    ```

4. **Verificando conexion**

    ```bash
        ping
    ```

5. **Informacion del servidor**

    ```bash
        INFO
    ```

## Cadena de Conexion
 Configuracion para un proyecto de JAVA con SPRING BOOT (application.properties).

    ```bash
        # Configuración de Redis
        spring.redis.host=${REDIS_HOST:localhost}
        spring.redis.port=${REDIS_PORT:6379}
        spring.redis.password=${REDIS_PASSWORD:mysecurepassword}
    ```

## Contribuciones
Las contribuciones son bienvenidas. Siéntete libre de mejorar este proyecto, agregar nuevas característifcas o corregir problemas identificados. Para contribuir, crea un Pull Request o abre un Issue.

## Licencia
Este proyecto está bajo la licencia MIT License.