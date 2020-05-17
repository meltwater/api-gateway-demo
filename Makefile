test: compose-up-test test_deps
	sleep 5
	bundle exec rspec ./tests/spec
	docker-compose -f docker-compose-test.yml down

test_deps:
	bundle install
	
compose-reload:
	docker-compose -f docker-compose-test.yml exec web nginx -s reload

compose-up-test:
	docker-compose -f docker-compose-test.yml up -d --build
