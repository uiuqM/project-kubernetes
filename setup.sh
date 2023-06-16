#!/bin/bash

minikube status > /dev/null 2>&1

if [ $? -ne 0 ]; then
  echo "Iniciando minikube..."
  minikube start
fi

kubectl apply -f ./

host=$(minikube service api-service --url)


touch nginx.conf

echo "user nobody; # a directive in the 'main' context

events {
    # configuration of connection processing
}

http {
    # Configuration specific to HTTP and affecting all virtual servers  

    server {
        listen 8080;
        # configuration of HTTP virtual server 1       
        location /{
          proxy_pass ${host};
        }
    } 
    
    server {
        # configuration of HTTP virtual server 2
    }
}" > nginx.conf

echo "Pronto! acesse: ${host}"