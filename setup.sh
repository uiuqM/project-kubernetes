#!/bin/bash

echo "Iniciando minikube..."
minikube start

kubectl apply -f ./

host=$(minikube service api-service --url)


touch nginx.conf

echo "user www-data; # a directive in the 'main' context
worker_processes auto;
pid /run/nginx.pid;
include /etc/nginx/modules-enabled/*.conf;

events {
    # configuration of connection processing
    worker_connections 768;
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
    gzip on;

    include /etc/nginx/conf.d/*.conf;
    include /etc/nginx/sites-enabled/*;
}" > nginx.conf

echo "Pronto! acesse: ${host}"