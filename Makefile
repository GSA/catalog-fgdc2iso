.PHONY: build test

build:
	mkdir -p build
	docker-compose build
	docker-compose run --rm -v $(PWD)/build:/build app bash -c 'cp $${TOMCAT_WEBAPPS_DIR}/fgdc2iso.war /build/'

test:
	docker-compose -f docker-compose.yml -f docker-compose.test.yml build
	docker-compose -f docker-compose.yml -f docker-compose.test.yml up --abort-on-container-exit test
