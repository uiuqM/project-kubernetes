#!/bin/bash

minikube status > /dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Iniciando minikube..."
  minikube start
fi

kubectl apply -f ./

ip=$(minikube ip)

out=$(kubectl get svc | grep 80:)

port=$(echo ${out} | awk '{print $5}' | cut -d':' -f2 | cut -d'/' -f1)

echo "Pronto! acesse: http://${ip}:${port}"