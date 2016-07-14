FROM mariadb:10

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

ADD ./conf/cluster.cnf /etc/mysql/conf.d/cluster.cnf

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
