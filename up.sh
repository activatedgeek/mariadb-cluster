#!/usr/bin/env bash

set -e

MARIADB_CLUSTER_NAME=mariadb-test-cluster
MYSQL_ROOT_PASSWORD=123

# start the bootstrap node
docker run -d --name node1 \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  activatedgeek/mariadb:devel \
  --wsrep-cluster-name=$MARIADB_CLUSTER_NAME \
  --wsrep-cluster-address=gcomm://

# allow time for MySQL Init
sleep 15

# connect node2 to the cluster
docker run -d --name node2 --link node1:node1 \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  activatedgeek/mariadb:devel \
  --wsrep-cluster-name=$MARIADB_CLUSTER_NAME \
  --wsrep-cluster-address=gcomm://node1

# connect node3 to the cluster
docker run -d --name node3 --link node1:node1 \
  -e MYSQL_ROOT_PASSWORD=$MYSQL_ROOT_PASSWORD \
  activatedgeek/mariadb:devel \
  --wsrep-cluster-name=$MARIADB_CLUSTER_NAME \
  --wsrep-cluster-address=gcomm://node1
