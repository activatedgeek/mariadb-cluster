# MariaDB Docker Cluster

A helper repository to get MariaDB cluster ready for production. This is not
a production-ready reference but I am expecting to update the configurations
as and when I make progress.

Though just a POC, if combined with a front-end proxy for load balancing (like `proxysql`),
service discovery for multi-host clusters (cluster on a single-host won't
make sense anyways) and some careful configurations, it should be ready for
production.

## Aim

* All cluster-wide and client communication via SSL/TLS
* Load balance requests across all master-master replicated nodes
* Understand and add memory related configurations like `innodb_buffer_pool_size`

## Usage

### Build the Docker image

```
$ make devel
```

The Docker file adds a `cluster.cnf` over the official `MariaDB` (10.x) image
to enable Galera replication.

### Start the cluster

```
$ make up
```

This script will start a 3-node cluster (the minimum recommended to prevent a
split-brain scenario). The service definitions are in [`docker-compose.yml`](./docker-compose.yml).

**WARNING**: The bootstrap node must be allowed to init completely before
adding more nodes to the cluster (hence not using `docker-compose up -d` directly).
If not enough time give, it strangely goes into a deadlock and crashes.

### Check cluster size

```
$ make check
```

**NOTE**: This asks for MySQL root password which is `123`.

The expected output should be:
```
+--------------------+-------+
| Variable_name      | Value |
+--------------------+-------+
| wsrep_cluster_size | 3     |
+--------------------+-------+
```

It might take a while for the cluster to connect as the MySQL init process takes
a little time to boot up.

As you can see, we have successfully created a cluster of size 3 with synchronous
replication enabled across the 3 nodes. Go ahead and insert data into one of the
containers and you should see that available almost instantly on the other 2 nodes
as well.

### Cleanup

```
$ make down
```

This will delete the docker image as well as the three containers.

## Have ideas?

Please help me out. Open a discussion as an issue or send a pull request with
better production-ready configurations.
