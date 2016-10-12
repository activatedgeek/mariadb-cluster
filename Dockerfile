FROM mariadb:10.1

MAINTAINER Sanyam Kapoor "1sanyamkapoor@gmail.com"

ADD ./conf/cluster.cnf /etc/mysql/conf.d/cluster.cnf

EXPOSE 3306 4444 4567 4567/udp 4568

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
