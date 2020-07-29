FROM apline:3.12.0

WORKDIR /app
VOLUME /app

RUN apk add --update mysql mysql-client \
  && rm -rf /var/cache/apk/*

COPY ./startup /startup
COPY ./conf/mysql/my.cnf /etc/mysql/my.cnf

EXPOSE 3306
CMD ["/startup/startup.sh"]
