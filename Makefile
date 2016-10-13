up:
	@docker-compose up -d boot
	@echo "Pausing 90 seconds to wait for bootstrap node init.."
	@sleep 90
	@echo "Adding nodes to the cluster.."
	@docker-compose up -d node1 node2

check:
	@docker exec -it maria_boot mysql -p123 -e 'show status like "wsrep%"'
	@docker exec -it maria_node1 mysql -p123 -e 'show status like "wsrep%"'
	@docker exec -it maria_node2 mysql -p123 -e 'show status like "wsrep%"'

down:
	@docker-compose down

clean:
	@rm -rf ./data/
