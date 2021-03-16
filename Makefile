migrations:
	python3 manage.py makemigrations

migrate:migrations
	python3 manage.py migrate

superuser:migrate
	python3 manage.py createsuperuser --noinput

runserver:superuser
	python3 manage.py runserver 0.0.0.0:8000

build:
	docker build -t oscar-container . 

run:
	docker run -p8000:8000 --volume "C:/Users/mikai/Desktop/kitanda_shop/src/:/app" --env-file etc/dev.env -it oscar-container

up:build
	docker run -p8000:8000 --volume "C:/Users/mikai/Desktop/kitanda_shop/src/:/app" --env-file etc/dev.env -it oscar-container

shell:
	docker exec oscar-container 
