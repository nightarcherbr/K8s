#!/bin/bash

set -x

# Criando usuarios 
groupadd --system --gid 101 nginx
useradd --system --gid nginx --no-create-home --home /nonexistent --comment "nginx user" --shell /bin/false --uid 101 nginx
echo "Criando usuario padrão";

# Listando pacotes
echo "Instalando pacotes" $PACKAGES;
apt-get update
apt-get install --no-install-recommends --no-install-suggests -y gnupg gnupg1 ca-certificates apt-utils

# Instalando certificados
echo "Instalando Certificados";
curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null
gpg  --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian bookworm nginx" | tee /etc/apt/sources.list.d/nginx.list;


# Instalando o NGINX
echo "Instalando NGINX"
apt-get update
apt-get install --no-install-recommends --no-install-suggests -y nginx nginx-module-xslt nginx-module-geoip nginx-module-otel nginx-module-image-filter nginx-module-njs gettext-base gettext-base curl
apt-get remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list

# forward request and error logs to docker log collector
ln -sf /dev/stdout /var/log/nginx/access.log;
ln -sf /dev/stderr /var/log/nginx/error.log;

# create a docker-entrypoint.d directory
mkdir -p /docker-entrypoint.d;
mkdir -p /etc/nginx/templates;
mkdir -p /etc/nginx/snippets;