.PHONY: clean build test down all help

clean: ##Stop and remove containers and volumes
	docker-compose down -v --remove-orphans --rmi local

build:  ##Build the fgdc2iso war file and build and run TomCat container with new war file
	mkdir -p build
	docker-compose build
	docker-compose run --rm -v $(PWD)/build:/build app bash -c 'cp $${TOMCAT_WEBAPPS_DIR}/fgdc2iso.war /build/'

test: ##Build the test container and run bats test
	docker-compose -f docker-compose.yml -f docker-compose.test.yml build
	docker-compose -f docker-compose.yml -f docker-compose.test.yml up --abort-on-container-exit test

down: ##Bring down the TomCat server
	docker-compose down

all: clean build test down ##Clean, build containers, build WAR file, bring up TomCat server, run the tests, and bring the server down

# Output documentation for top-level targets
# Thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: help
help: ##Show this help message
	@printf "\nUsage : make <commands> \n\nThe following commands are available :"
	@awk 'BEGIN {FS = ":.*##"; printf "\n"} /^[a-zA-Z_-]+:.*?##/ { printf "%s:\t%s\n", $$1, $$2 } /^##@/' $(MAKEFILE_LIST)
	@printf "\n"

