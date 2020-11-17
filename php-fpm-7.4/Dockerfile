FROM php:7.4.12-fpm-buster

RUN set -x && \
#
  apt-get update && \
  apt-mark showmanual >/tmp/apt-mark && \
#
  docker-php-source extract && \
###
# ext: bcmath
  docker-php-ext-configure bcmath --enable-bcmath && \
  docker-php-ext-install bcmath && \
# ext: bz2
  apt-get install -y --no-install-recommends libbz2-dev && \
  docker-php-ext-configure bz2 -with-bz2 && \
  docker-php-ext-install bz2 && \
# ext: calendar
  docker-php-ext-configure calendar --enable-calendar && \
  docker-php-ext-install calendar && \
# ext: ctype
# ext: curl
# ext: dba
  docker-php-ext-configure dba --enable-dba && \
  docker-php-ext-install dba && \
# ext: dom
# ext: enchant
  apt-get install -y --no-install-recommends libenchant-dev && \
  docker-php-ext-configure enchant --with-enchant && \
  docker-php-ext-install enchant && \
# ext: exif
  docker-php-ext-configure exif --enable-exif && \
  docker-php-ext-install exif && \
# ext: ffi
  docker-php-ext-configure ffi --with-ffi && \
  docker-php-ext-install ffi && \
# ext: fileinfo
# ext: filter
# ext: ftp
# ext: gd
  apt-get install -y --no-install-recommends libjpeg-dev libpng-dev libfreetype6-dev libwebp-dev libgif-dev && \
  docker-php-ext-configure gd --enable-gd --with-webp --with-jpeg --with-freetype && \
  docker-php-ext-install gd && \
# ext: gettext
  docker-php-ext-configure gettext --with-gettext && \
  docker-php-ext-install gettext && \
# ext: gmp
  apt-get install -y --no-install-recommends libgmp-dev && \
  docker-php-ext-configure gmp --with-gmp && \
  docker-php-ext-install gmp && \
# ext: hash
# ext: iconv
# ext: imap
  apt-get install -y --no-install-recommends libc-client-dev libkrb5-dev && \
  docker-php-ext-configure imap --with-kerberos --with-imap-ssl && \
  docker-php-ext-install imap && \
# ext: intl
  apt-get install -y --no-install-recommends libicu-dev && \
  docker-php-ext-configure intl --enable-intl && \
  docker-php-ext-install intl && \
# ext: json
# ext: ldap
  apt-get install -y --no-install-recommends libldap2-dev libsasl2-dev && \
  docker-php-ext-configure ldap --with-ldap --with-ldap-sasl && \
  docker-php-ext-install ldap && \
# ext: mbstring
# ext: mysqli
  docker-php-ext-configure mysqli --with-mysqli && \
  docker-php-ext-install mysqli && \
# ext: oci8
# ext: odbc
# ext: opcache
  docker-php-ext-install opcache && \
# ext: pcntl
  docker-php-ext-configure pcntl --enable-pcntl && \
  docker-php-ext-install pcntl && \
# ext: pdo
# ext: pdo_dblib
  apt-get install -y --no-install-recommends freetds-dev && \
  docker-php-ext-configure pdo_dblib --with-libdir=lib/x86_64-linux-gnu && \
  docker-php-ext-install pdo_dblib && \
# ext: pdo_firebird
  apt-get install -y --no-install-recommends firebird-dev && \
  docker-php-ext-configure pdo_firebird --with-pdo-firebird && \
  docker-php-ext-install pdo_firebird && \
# ext: pdo_mysql
  docker-php-ext-configure pdo_mysql --with-pdo-mysql --with-zlib-dir && \
  docker-php-ext-install pdo_mysql && \
# ext: pdo_oci
# ext: pdo_odbc
  apt-get install -y --no-install-recommends unixodbc-dev && \
  docker-php-ext-configure pdo_odbc --with-pdo-odbc=unixODBC,/usr && \
  docker-php-ext-install pdo_odbc && \
# ext: pdo_pgsql
  apt-get install -y --no-install-recommends libpq-dev && \
  docker-php-ext-configure pdo_pgsql --with-pdo-pgsql && \
  docker-php-ext-install pdo_pgsql && \
# ext: pdo_sqlite
# ext: pgsql
  apt-get install -y --no-install-recommends libpq-dev && \
  docker-php-ext-configure pgsql --with-pgsql && \
  docker-php-ext-install pgsql && \
# ext: phar
# ext: posix
# ext: pspell
  apt-get install -y --no-install-recommends libpspell-dev && \
  docker-php-ext-configure pspell --with-pspell && \
  docker-php-ext-install pspell && \
# ext: readline
# ext: reflection
# ext: session
# ext: shmop
  docker-php-ext-configure shmop --enable-shmop && \
  docker-php-ext-install shmop && \
# ext: simplexml
# ext: snmp
  apt-get install -y --no-install-recommends libsnmp-dev snmp && \
  echo "snmp" >>/tmp/apt-mark && \
  docker-php-ext-configure snmp --with-snmp && \
  docker-php-ext-install snmp && \
# ext: soap
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-configure soap --enable-soap && \
  docker-php-ext-install soap && \
# ext: sockets
  docker-php-ext-configure sockets --enable-sockets && \
  docker-php-ext-install sockets && \
# ext: sodium
# ext: spl
# ext: standard
# ext: sysvmsg
  docker-php-ext-configure sysvmsg --enable-sysvmsg && \
  docker-php-ext-install sysvmsg && \
# ext: sysvsem
  docker-php-ext-configure sysvmsg --enable-sysvmsg && \
  docker-php-ext-install sysvsem && \
# ext: sysvshm
  docker-php-ext-configure sysvmsg --enable-sysvmsg && \
  docker-php-ext-install sysvshm && \
# ext: tidy
  apt-get install -y --no-install-recommends libtidy-dev && \
  docker-php-ext-configure tidy --with-tidy && \
  docker-php-ext-install tidy && \
# ext: tokenizer
# ext: xml
# ext: xmlreader
# ext: xmlrpc
  apt-get install -y --no-install-recommends libxml2-dev && \
  docker-php-ext-configure xmlrpc --with-xmlrpc && \
  docker-php-ext-install xmlrpc && \
# ext: xmlwriter
# ext: xsl
  apt-get install -y --no-install-recommends libxslt1-dev && \
  docker-php-ext-configure xsl --with-xsl && \
  docker-php-ext-install xsl && \
# ext: zend_test
  docker-php-ext-configure zend_test --enable-zend-test && \
  docker-php-ext-install zend_test && \
# ext: zip
  apt-get install -y --no-install-recommends zlib1g-dev libzip-dev && \
  docker-php-ext-configure zip --with-zip && \
  docker-php-ext-install zip && \
###
# pecl: amqp
  apt-get install -y --no-install-recommends librabbitmq-dev && \
  pecl install -f amqp && \
  docker-php-ext-enable amqp && \
# pecl: apcu
  pecl install -f apcu && \
  docker-php-ext-enable apcu && \
# pecl: ast
  pecl install -f ast && \
  docker-php-ext-enable ast && \
# pecl: ds
  pecl install -f ds && \
  docker-php-ext-enable ds && \
# ext: sockets
  docker-php-ext-configure sockets --enable-sockets && \
  docker-php-ext-install sockets && \
# pecl: event
  apt-get install -y --no-install-recommends libevent-dev libssl-dev && \
  pecl install -f event && \
  docker-php-ext-enable event && \
# pecl: geoip
  apt-get install -y --no-install-recommends libgeoip-dev && \
  pecl install -f geoip-beta && \
  docker-php-ext-enable geoip && \
# pecl: grpc
  apt-get install -y --no-install-recommends libzip-dev && \
  pecl install -f grpc && \
  docker-php-ext-enable grpc && \
# ext: sockets
  docker-php-ext-install sockets && \
# pecl: igbinary
  pecl install -f igbinary && \
  docker-php-ext-enable igbinary && \
# pecl: imagick
  apt-get install -y --no-install-recommends libmagick++-dev && \
  pecl install -f imagick && \
  docker-php-ext-enable imagick && \
# pecl: mcrypt
  apt-get install -y --no-install-recommends libmcrypt-dev && \
  pecl install -f mcrypt && \
  docker-php-ext-enable mcrypt && \
# pecl: memcached
  apt-get install -y --no-install-recommends libmemcached-dev libzip-dev && \
  pecl install -f memcached && \
  docker-php-ext-enable memcached && \
# pecl: mongodb
  pecl install -f mongodb && \
  docker-php-ext-enable mongodb && \
# pecl: oauth
  apt-get install -y --no-install-recommends libpcre3-dev && \
  pecl install -f oauth && \
  docker-php-ext-enable oauth && \
# pecl: rdkafka
  apt-get install -y --no-install-recommends librdkafka-dev && \
  pecl install -f rdkafka && \
  docker-php-ext-enable rdkafka && \
# pecl: redis
  pecl install -f redis && \
  docker-php-ext-enable redis && \
# pecl: uuid
  apt-get install -y --no-install-recommends uuid-dev && \
  pecl install -f uuid && \
  docker-php-ext-enable uuid && \
# pecl: xdebug
  pecl install -f xdebug-beta && \
  docker-php-ext-enable xdebug && \
# pecl: yaml
  apt-get install -y --no-install-recommends libyaml-dev && \
  pecl install -f yaml && \
  docker-php-ext-enable yaml && \
###
  docker-php-source delete && \
#
  apt-mark auto '.*' >/dev/null && \
  [ -z "$(cat /tmp/apt-mark)" ] || apt-mark manual $(cat /tmp/apt-mark) && \
  find /usr/local -type f -name '*.so*' -exec ldd '{}' ';' | awk '/=>/ { print $(NF-1) }' | sort -u | \
    xargs -r dpkg-query --search | cut -d: -f1 | sort -u | xargs -r apt-mark manual && \
  apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false && \
  rm -rf /tmp/* ~/.pearrc /var/lib/apt/lists/*
