ARG NGINX_IMAGE=
ARG PHP_FPM_IMAGE=
ARG GOMPLATE_VERSION=3.8.0

FROM "${NGINX_IMAGE}"

FROM "${PHP_FPM_IMAGE}"

LABEL maintainer="Alex Kataev <dlyavsehpisem@gmail.com>"

ARG GOMPLATE_VERSION

ENV COMPOSER_NO_INTERACTION=1

COPY --from=0 /usr/src/nginx-deb /usr/src/nginx-deb/

RUN set -x && \
#
  apt-get update && \
  apt-get install -y --no-install-recommends git zip unzip curl ca-certificates vim net-tools procps less tree && \
  apt-get install -y --no-install-recommends libfcgi-bin && \
  rm -rf /var/lib/apt/lists/* && \
#
  ( \
    echo '[global]'; \
    echo 'daemonize = no'; \
    echo; \
    echo '[www]'; \
    echo 'user = www-data'; \
    echo 'group = www-data'; \
    echo 'listen = /var/run/php-fpm.sock'; \
    echo 'listen.owner = www-data'; \
    echo 'listen.group = www-data'; \
    echo 'listen.mode = 0660'; \
    echo 'ping.path = /ping'; \
    echo 'ping.response = pong'; \
    echo 'access.log = /proc/self/fd/1'; \
  ) | tee /usr/local/etc/php-fpm.d/zz-docker.conf >/dev/null && \
  ( \
    echo '[www]'; \
    echo 'pm = dynamic'; \
    echo 'pm.max_children = 5'; \
    echo 'pm.start_servers = 2'; \
    echo 'pm.min_spare_servers = 1'; \
    echo 'pm.max_spare_servers = 3'; \
    echo; \
  ) | tee /usr/local/etc/php-fpm.d/www.conf >/dev/null && \
#
  curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer && \
#
  IONCUBE_SO="ioncube_loader_lin_$((php -r 'echo PHP_VERSION;' | grep -oE '7.[2-4]+') || echo -n '7.4').so"
  curl -s https://downloads.ioncube.com/loader_downloads/ioncube_loaders_lin_x86-64.tar.gz | \
    tar xzf - -C /usr/local/lib/php/extensions "ioncube/${IONCUBE_SO}" --strip-components=1 && \
  echo "zend_extension=/usr/local/lib/php/extensions/${IONCUBE_SO}" \
    >/usr/local/etc/php/conf.d/00-docker-php-ext-ioncube.ini && \
#
  curl -sL -o /usr/local/bin/gomplate \
    "https://github.com/hairyhenderson/gomplate/releases/download/v${GOMPLATE_VERSION}/gomplate_linux-amd64" && \
  chmod +x /usr/local/bin/gomplate && \
#
  echo "deb [ trusted=yes ] file:///usr/src/nginx-deb ./" > /etc/apt/sources.list.d/nginx.list && \
  apt-get -o Acquire::GzipIndexes=false update && \
  apt-get install -y --no-install-recommends nginx && \
  apt-get install -y --no-install-recommends nginx-module-* && \
  rm -rf /var/lib/apt/lists/* /etc/apt/sources.list.d/nginx.list /usr/src/nginx-deb/* && \
#
  ln -sf /dev/stdout /var/log/nginx/access.log && \
  ln -sf /dev/stderr /var/log/nginx/error.log && \
#
  sed -i 's/^user .*/user www-data www-data;/g' /etc/nginx/nginx.conf && \
  userdel nginx && \
#
  rm -rf /var/www/*

WORKDIR /var/www

HEALTHCHECK \
  --interval=10s \
  --timeout=5s \
  --start-period=1ms \
  --retries=3 \
  CMD \
  /docker-entrypoint.sh healthcheck

EXPOSE 80

ADD docker-entrypoint.sh /

RUN set -x && \
  chmod +x /docker-entrypoint.sh && \
  ln -s /docker-entrypoint.sh /usr/local/bin/cmd

ENTRYPOINT ["/docker-entrypoint.sh"]
