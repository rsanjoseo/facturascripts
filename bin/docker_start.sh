#!/bin/bash

clear

cd docker

echo "Levantando los contenedores de mifactura con docker compose..."
docker compose up -d fs_nginx fs_php fs_db fs_phpmyadmin # fs_phpmyadmin_testing fs_db_testing

cd ..
echo "Listado de contenedores"
docker ps