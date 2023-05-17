#!/bin/bash

minikube status > /dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Iniciando minikube..."
  minikube start
fi

kubectl apply -f ./

host=$(minikube service api-service --url)

echo "Pronto! acesse: ${host}"