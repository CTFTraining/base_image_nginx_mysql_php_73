FROM php:7.3-fpm-alpine

LABEL Organization="CTFTraining" Author="Virink <virink@outlook.com>"

MAINTAINER Virink@CTFTraining <virink@outlook.com>

COPY _files /tmp/
COPY src /var/www/html

RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.ustc.edu.cn/g' /etc/apk/repositories \
    && apk add --update --no-cache tar nginx mysql mysql-client \
    && mkdir /run/nginx \
    # mysql ext
    && docker-php-source extract \
    && docker-php-ext-install pdo_mysql mysqli \
    && docker-php-source delete \
    # init mysql
    && mysql_install_db --user=mysql --datadir=/var/lib/mysql \
    && sh -c 'mysqld_safe &' \
    && sleep 5s \
    && mysqladmin -uroot password 'root' \
    && mysql -e "source /var/www/html/db.sql;" -uroot -proot \
    # configure file
    && mv /tmp/flag.sh /flag.sh \
    && mv /tmp/docker-php-entrypoint /usr/local/bin/docker-php-entrypoint \
    && chmod +x /usr/local/bin/docker-php-entrypoint \
    && mv /tmp/nginx.conf /etc/nginx/nginx.conf \
    && chown -R www-data:www-data /var/www/html \    
    && mv /tmp/docker-php-ext-mysqli.ini /usr/local/etc/php/conf.d \
    && mv /tmp/docker-php-ext-pdo_mysql.ini /usr/local/etc/php/conf.d \
    # clear
    && rm -rf /var/www/html/db.sql \
    && rm -rf /tmp/*

WORKDIR /var/www/html

EXPOSE 80

VOLUME ["/var/log/nginx"]

CMD ["/bin/bash", "-c", "docker-php-entrypoint"]
