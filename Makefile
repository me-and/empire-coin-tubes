all: tube.stl

.docker/build: Dockerfile
	docker build --tag openscad .
	mkdir -p .docker
	touch .docker/build

%.stl: %.scad .docker/build
	docker run --rm --volume $$(pwd):/build openscad -o $@ $<
