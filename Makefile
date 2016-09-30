devel:
	@docker build -t activatedgeek/mariadb:devel .

up:
	@docker-compose up -d boot
	@echo "Pausing 90 seconds to wait for bootstrap node full init.."
	@sleep 90
	@echo "Adding 2 nodes to the cluster.."
	@docker-compose up -d node
	@docker-compose scale node=2

check:
	@docker exec -it mariadbcluster_boot_1 mysql -p -e 'show status like "wsrep_cluster_size"'

down:
	@docker-compose down
	@docker rmi activatedgeek/mariadb:devel
