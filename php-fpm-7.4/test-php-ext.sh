#!/bin/bash

set -e

exts=(amqp apcu ast bcmath bz2 calendar dba ds enchant event exif ffi gd geoip gettext gmp grpc igbinary imagick imap intl ldap mcrypt memcached mongodb mysqli oauth opcache pcntl pdo_dblib pdo_firebird pdo_mysql pdo_odbc pdo_pgsql pgsql pspell rdkafka redis shmop snmp soap sockets sodium sysvmsg sysvsem sysvshm tidy uuid xdebug xmlrpc xsl yaml zend_test zip)

for e in ${!exts[@]}; do
  ext="${exts[$e]}"
  case ${ext} in
    "event")
      (set -x; /docker-entrypoint.sh php-ext-enable "sockets,${ext}")
      ;;
    "opcache")
      (set -x; /docker-entrypoint.sh php-ext-enable "${ext}")
      ext="zend opcache"
      ;;
    "zend_test")
      (set -x; /docker-entrypoint.sh php-ext-enable "${ext}")
      ext="zend-test"
      ;;
    *)
      (set -x; /docker-entrypoint.sh php-ext-enable "${ext}")
      ;;
  esac
  (set -x; php --ri "${ext}" >/dev/null)
  /docker-entrypoint.sh php-ext-enable _
done
