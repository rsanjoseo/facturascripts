#!/bin/bash

clear

# Eliminar datos temporales, directorios innecesarios y archivos relacionados con Composer
# Esto es útil para reiniciar tu entorno limpio antes de reconstruir los contenedores
echo "Limpiando archivos y directorios..."
sudo rm -rf docker/etc/db/mysql/data tmp node_modules vendor composer.lock package-lock.json

# Cambiar al directorio del proyecto
echo "Cambiando al directorio del proyecto docker..."
cd docker

# Detener y eliminar los contenedores relevantes para evitar conflictos
# Solo se detendrán y eliminarán los contenedores especificados
echo "Deteniendo y eliminando los contenedores de mifactura..."
docker stop fs_nginx fs_php fs_db fs_phpmyadmin # fs_phpmyadmin_testing fs_db_testing
docker remove fs_nginx fs_php fs_db fs_phpmyadmin # fs_phpmyadmin_testing fs_db_testing

# Limpiar imágenes y contenedores no utilizados para liberar espacio
# Este comando elimina todos los contenedores detenidos, redes no usadas, e imágenes sin etiquetas
echo "Limpiando Docker..."
docker system prune -a -f

# Levantar los contenedores en segundo plano con 'docker compose up -d'
# Esto reconstruye y levanta los contenedores según el archivo docker-compose.yml
echo "Levantando contenedores con docker compose..."
docker compose up -d

# Ejecutar comandos dentro del contenedor PHP para instalar dependencias
# Se establece la variable COMPOSER_ALLOW_SUPERUSER=1 para permitir la ejecución de Composer como superusuario
# Luego, se instalan dependencias de npm y se construye el proyecto con gulp
echo "Instalando dependencias y construyendo el proyecto dentro del contenedor fs_php..."
docker exec fs_php sudo -- bash -c 'COMPOSER_ALLOW_SUPERUSER=1; npm install && gulp build'

# Transferir los archivos de 'vendor' y 'node_modules' al contenedor fs_php
# Esto asegura que las dependencias estén disponibles dentro del contenedor PHP
echo "Transferiendo archivos de vendor y node_modules al contenedor fs_php..."
docker cp ../vendor fs_php:/var/www/html/vendor
docker cp ../node_modules fs_php:/var/www/html/node_modules

# Transferir los mismos archivos al contenedor fs_nginx para asegurar que también estén disponibles para Nginx
echo "Transferiendo archivos de vendor y node_modules al contenedor fs_nginx..."
docker cp ../vendor fs_nginx:/var/www/html/vendor
docker cp ../node_modules fs_nginx:/var/www/html/node_modules

# Abrir la página de la aplicación en el navegador predeterminado
# Esto abre la URL http://localhost en el navegador para que puedas ver la aplicación
echo "Abriendo la aplicación en el navegador..."
xdg-open https://localhost &

# Regresar al directorio anterior para terminar el script
cd ..
