FROM mysql:latest
ENV MYSQL_ROOT_PASSWORD=password
ENV MYSQL_DATABASE=CuminDB
# COPY ./dump.sql /docker-entrypoint-initdb.d/

COPY custom.cnf /etc/mysql/conf.d/