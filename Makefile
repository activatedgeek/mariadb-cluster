devel:
	@docker build -t activatedgeek/mariadb:devel .

up:
	@bash ./up.sh

check:
	@docker exec -it node1 mysql -p -e 'show status like "wsrep_cluster_size"'

down:
	@docker rm -f node1 node2 node3
	@docker rmi activatedgeek/mariadb:devel
