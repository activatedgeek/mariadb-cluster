up:
	@docker-compose up -d boot
	@echo "Pausing 90 seconds to wait for bootstrap node init.."
	@sleep 90
	@echo "Adding nodes to the cluster.."
	@docker-compose up -d node1 node2

check:
	@docker exec -it mariadbcluster_boot_1 mysql -p123 -e 'show status like "wsrep_%"'

down:
	@docker-compose down

clean:
	@rm -rf ./data/
