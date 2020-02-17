#!/bin/bash

#
# Deploy minio-upload
#
# Por: Tiago Geremias
# <https://github.com/tiagopgeremias>  
# <tiagopgeremias@gmail.com>
#
# 
#
#

if [ $(whoami) != "root" ];
then
  echo "Erro ao executar o deploy."
  echo "Execute: sudo $0"
  exit 1
fi

# Finalizando o processo do Gunicorn
if [ $(ps -ef | grep gunicorn | grep -v grep | wc -l) -gt 0 ];
then
  kill -9 $(ps -ef | grep gunicorn | grep -v grep)
fi

echo "Deploy finalizado com sucesso."


