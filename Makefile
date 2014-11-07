.PHONY: all test clean

all: reload run

reload: halt up provision

halt:
	vagrant halt

up:
	vagrant up

provision:
	vagrant provision

upgrade:
	vagrant ssh -c 'sudo docker pull digibib/koha'
	vagrant ssh -c 'sudo docker pull digibib/koha-restful'

stop_restful: 
	@echo "======= STOPPING KOHA-RESTFUL CONTAINER ======\n"
	vagrant ssh -c 'sudo docker stop koha_restful' || true

stop_koha: 
	@echo "======= STOPPING KOHA CONTAINER ======\n"
	vagrant ssh -c 'sudo docker stop koha_docker' || true

delete_restful: stop_restful
	@echo "======= DELETING KOHA-RESTFUL CONTAINER ======\n"
	vagrant ssh -c 'sudo docker rm koha_restful' || true

delete_koha: stop_koha
	@echo "======= DELETING KOHA CONTAINER ======\n"
	vagrant ssh -c 'sudo docker rm koha_docker' || true

delete: stop delete_koha delete_restful

stop: stop_koha stop_restful

# start koha with koha-restful container
run: delete run_restful run_koha
	@echo "======= RUNNING KOHA CONTAINER WITH VOLUMES FROM KOHA RESTFUL======\n"

run_restful:
	@vagrant ssh -c 'sudo docker run -it --name koha_restful digibib/koha-restful echo "yes"'

run_koha:
	@vagrant ssh -c 'sudo docker run -d --name koha_docker --volumes-from=koha_restful \
	-p 80:80 -p 8080:8080 -p 8081:8081 -t digibib/koha' || echo "koha_docker container \
	already running, please _make delete_ first"

logs:
	vagrant ssh -c 'sudo docker logs koha_docker'

logs-f:
	vagrant ssh -c 'sudo docker logs -f koha_docker'

test: test_sanity

test_sanity:
	@echo "======= TESTING KOHA-RESTFUL SANITY ======\n"
	vagrant ssh -c 'cd vm-test && python test.py koha_docker'


clean:
	vagrant destroy --force
