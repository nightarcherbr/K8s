FROM php:8.2-fpm-bookworm


ENV NGINX_VERSION=1.27.2
ENV NJS_VERSION=0.8.6
ENV NJS_RELEASE=1~bookworm
ENV PKG_RELEASE=1~bookworm
ENV DYNPKG_RELEASE=1~bookworm

# Instalando bibliotecas e pacotes do APT
RUN apt update && \ 
  apt install --no-install-recommends --no-install-suggests -y gpg && \
  apt remove --purge --auto-remove -y && apt clean && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list;


# Processando
RUN set -x && \
    echo "Criando usuarios" && \
    groupadd --system --gid 101 nginx && \
    useradd --system --gid nginx --no-create-home --home /nonexistent --comment "nginx user" --shell /bin/false --uid 101 nginx && \
    echo "Configurando repositorios do NGINX" && \
    curl https://nginx.org/keys/nginx_signing.key | gpg --dearmor | tee /usr/share/keyrings/nginx-archive-keyring.gpg >/dev/null && \
    gpg  --dry-run --quiet --no-keyring --import --import-options import-show /usr/share/keyrings/nginx-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/nginx-archive-keyring.gpg] http://nginx.org/packages/debian bookworm nginx" | tee /etc/apt/sources.list.d/nginx.list && \
    echo "Instalando NGINX" && \
    apt update && \
    apt install --no-install-recommends --no-install-suggests -y ca-certificates curl gettext-base ghostscript git gnupg gnupg1 iputils-ping libicu-dev libmagickwand-dev libmcrypt-dev librdkafka-dev libssl-dev libxslt-dev libzip-dev mcrypt supervisor zip zlib1g-dev nginx nginx-module-xslt nginx-module-geoip nginx-module-otel nginx-module-image-filter nginx-module-njs && \
    apt remove --purge --auto-remove -y && rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list && \
    ln -sf /dev/stdout /var/log/nginx/access.log && \
    ln -sf /dev/stderr /var/log/nginx/error.log && \
    mkdir -p /docker-entrypoint.d && \
    mkdir -p /etc/nginx/templates && \
    mkdir -p /etc/nginx/snippets;

# Configurando modulos do PHP-FPM
RUN pecl install mcrypt rdkafka apcu redis mongodb imagick && \ 
  docker-php-ext-enable mcrypt rdkafka.so apcu redis mongodb imagick && \
  docker-php-ext-install intl mysqli gettext gd exif shmop sockets zip xsl

# Instalando NGINXs
COPY nginx/docker-entrypoint.sh /
COPY nginx/10-listen-on-ipv6-by-default.sh /docker-entrypoint.d
COPY nginx/15-local-resolvers.envsh /docker-entrypoint.d
COPY nginx/20-envsubst-on-templates.sh /docker-entrypoint.d
COPY nginx/30-tune-worker-processes.sh /docker-entrypoint.d
COPY --chown=root:root php/policy.xml /etc/ImageMagick-6/policy.xml
COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer
COPY supervisor/supervisor.conf /etc/supervisor/conf.d/supervisord.conf


# Configuração do site default
COPY nginx/default.conf /etc/nginx/conf.d/
COPY nginx/snippets/ /etc/nginx/snippets/

EXPOSE 80
EXPOSE 443
EXPOSE 9000

# Sequencia de inicialização do container
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord"]
