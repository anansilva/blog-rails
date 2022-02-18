args = $(filter-out $@, $(MAKECMDGOALS))

# DEVELOPMENT
setup: # Copy configuration files locally needed for running Docker
	cp ./docker/config/database.sample.yml ./config/database.yml
up.d:
	docker-compose up --detach
up:
	docker-compose up
down:
	docker-compose down
build:
	docker-compose build --no-cache web
yarn:
	docker-compose run --rm web bash -c "yarn --network-timeout 100000"
bundle:
	docker-compose run --rm web bash -c "bundle"
bundle.update:
	docker-compose run --rm web bash -c "bundle update"
bash:
	docker-compose run --rm web bash
binding.pry:
	docker attach `docker-compose ps -q web`

# TDD
tdd:
	docker-compose -f docker-compose.tdd.yml run --rm tdd && \
		docker-compose -f docker-compose.tdd.yml down

%:
	@:

