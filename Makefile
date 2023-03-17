.PHONY: run build clean

run:
	docker run -it --rm -v $(shell pwd):/src -v ~/.aws:/root/.aws --name local-tooling local-tooling

build:
	docker build -t local-tooling .

clean:
	docker container rm local-tooling || true
	docker image rm local-tooling || true
