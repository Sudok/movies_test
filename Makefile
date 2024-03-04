#!make

build:
	docker compose build

start:
	docker compose up

silent_start:
	docker compose up -d

stop:
	docker compose stop

setup:
	make build && make bundle && make db_create && make db_migrate && make db_seed

bundle:
	docker compose run --rm app bundle install

db_create:
	docker compose run --rm app bundle exec rails db:create

db_migrate:
	docker compose run --rm app bundle exec rails db:migrate

db_seed:
	docker compose run --rm app bundle exec rails db:seed

db_reset:
	docker compose run --rm app bundle exec rails db:reset