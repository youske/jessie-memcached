IMAGE_NAME := youske/jessie-memcached

build: Dockerfile
	docker build --file Dockerfile -t ${IMAGE_NAME} .

build_nocache: Dockerfile
	docker build --no-cache --file Dockerfile -t ${IMAGE_NAME} .
