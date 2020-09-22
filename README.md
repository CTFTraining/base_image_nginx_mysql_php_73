# NEW

- **[base_web_nginx_mysql_php_56](https://github.com/ctfhub-team/base_web_nginx_mysql_php_56)**
- **[base_web_nginx_mysql_php_74](https://github.com/ctfhub-team/base_web_nginx_mysql_php_74)**


# Base Image LNMP

- L: Linux alpine
- N: Nginx
- M: MySQL
- P: PHP 7.3
- PHP MySQL Ext
    + mysql
    + mysqli

## Usage

### ENV

- FLAG=CTFTraining{nginx_mysql_php_73}
- FLAG_TABLE=flagtable
- FLAG_COLUMN=flagcolumn

### Files

- src 网站源码
    + db.sql 数据库文件
    + index.php
    + ...etc
- Dockerfile
- docker-compose.yml 可选

### Dockerfile

```
FROM ctftraining/base_image_nginx_mysql_php_73

COPY src /var/www/html

# 自定义 flag 方式
# COPY flag.sh /flag.sh
```

