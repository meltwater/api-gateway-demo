test: test_deps reload
	pytest -sv ./tests/spec/
	
reload:
	docker-compose -f docker-compose-test.yml exec web nginx -s reload

test_deps:
	pip install -r requirements.txt
	
start:
	docker-compose -f docker-compose-test.yml up -d --build

stop:
	docker-compose -f docker-compose-test.yml down