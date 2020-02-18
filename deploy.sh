#!/bin/bash

#
# Deploy minio-upload
#
# Por: Tiago Geremias
# <https://github.com/tiagopgeremias>  
# <tiagopgeremias@gmail.com>
#


if [ $(whoami) != "root" ];
then
  echo "Erro ao executar o deploy."
  echo "Execute: sudo $0"
  exit 1
fi

cd /opt/minio-upload

echo "Carregando o arquivo de Environment"
test -f .env && source .env || echo "Arquivo de .env nao encontrado" && exit 1

echo "Finalizando o processo do gunicorn"
if [ $(ps -ef | grep gunicorn | grep -v grep | wc -l) -gt 0 ];
then
  kill -9 $(ps -ef | grep gunicorn | grep -v grep)
fi

echo "Instalando dependencias do projeto"
pipenv --python 3 install --system --deploy

echo "Iniciando a aplicação"
gunicorn --chdir $(pwd) --bind 0.0.0.0:5000 wsgi:app &

echo "Deploy finalizado com sucesso."


