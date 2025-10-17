FROM mariadb:10.5

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y nano

ADD etc/db/mysql/init/create.sql /docker-entrypoint-initdb.d
