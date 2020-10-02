#!/bin/bash

set -e

php_ext_enable() {
  if [[ -n "${1}" ]]; then
    find /usr/local/etc/php/conf.d -mindepth 1 -maxdepth 1 \
      -type f -name '*docker-php-ext-*.ini' | \
        xargs -I '{}' mv '{}' '{}.disable'
    IFS=',' read -r -a modules <<< "${@}"
    for module in "${modules[@]}"; do
      find /usr/local/etc/php/conf.d -mindepth 1 -maxdepth 1 \
        -type f -name "*docker-php-ext-${module}.ini.disable" | \
          sed 's/.disable//' | xargs -I '{}' mv '{}.disable' '{}'
    done
  fi
}

SERVICE_NAME="${SERVICE_NAME:-${SERVICE}}"
SERVICE_MODE="${SERVICE_MODE:-normal}"

if [[ "${1}" == 'composer' ]]; then
  set -- su -l www-data -s /bin/bash -c "${*}"
  exec "${@}"
elif [[ "${1}" == 'php-ext-enable' ]]; then
  shift
  php_ext_enable "${@}"
elif [[ "${1}" == 'healthcheck' ]]; then
  SCRIPT_NAME=/ping SCRIPT_FILENAME=/ping REQUEST_METHOD=GET \
    cgi-fcgi -bind -connect /var/run/php-fpm.sock || \
      ps -C nginx -o pid= | grep -oE '([0-9]+)' | xargs kill
elif [[ "${#}" -eq '0' ]]; then
  php_ext_enable "${PHP_EXTENSIONS_ENABLE}"
  if [[ ! -d "/var/www/${SERVICE_NAME}" ]]; then
    mkdir -p "/var/www/${SERVICE_NAME}"
  fi
  find "/var/www/${SERVICE_NAME}" \
    \( ! -user 'www-data' -o ! -group 'www-data' \) \
    -exec chown www-data:www-data {} + 2>/dev/null
  if [[ "${SERVICE_MODE}" == 'templates' ]]; then
    test -d /templates && gomplate --input-dir /templates --output-dir /
  fi
  php-fpm &
  exec nginx -g 'daemon off;'
else
  exec "${@}"
fi
