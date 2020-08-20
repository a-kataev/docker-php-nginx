#!/bin/bash

set -e

exts=(amqp gmp pcntl sockets apcu grpc pdo_dblib sodium ast igbinary pdo_firebird sysvmsg bcmath imagick pdo_mysql sysvsem bz2 imap pdo_odbc sysvshm calendar interbase pdo_pgsql tidy dba intl pgsql uuid ds ldap pspell wddx enchant mcrypt rdkafka xdebug event memcached recode xmlrpc exif mongodb redis xsl gd mysqli shmop yaml geoip oauth snmp zend_test gettext opcache soap zip)

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
