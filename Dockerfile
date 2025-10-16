# Dockerfile para una imagen de Redis personalizada

# Usa una imagen base ligera de Redis.
# Es una buena práctica fijar la versión en lugar de usar 'latest'.
FROM redis:7.2-alpine

LABEL mantainer=luis122448
LABEL email=luis122448gmail

# Crea el directorio de configuración por si no existe
RUN mkdir -p /usr/local/etc/redis

# Copia el archivo de configuración personalizado al contenedor.
COPY redis.conf /usr/local/etc/redis/redis.conf

# Expone el puerto por defecto de Redis.
EXPOSE 6379

# Inicia el servidor de Redis usando nuestro archivo de configuración.
CMD [ "redis-server", "/usr/local/etc/redis/redis.conf" ]
