#!/bin/bash

clear

cd docker || exit

echo "Deteniendo contenedores de FacturaScripts..."
docker stop fs_nginx fs_php fs_db fs_phpmyadmin

echo "Eliminando contenedores de FacturaScripts..."
docker rm -f fs_nginx fs_php fs_db fs_phpmyadmin

cd .. || exit
echo "Listado de todos los contenedores:"
docker ps -a
