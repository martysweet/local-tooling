SRC_DIR := ~/development/martysweet/
CUR_DIR := $(shell basename "$(shell pwd)")

.PHONY: run build clean

run:
	test -f .zsh_history || touch ~/.zsh_history
	docker run -it --rm \
			-e LOCAL_USER_ID=`id -u` \
			-v $(SRC_DIR):/src \
			-v ~/.aws:/root/.aws \
			-v ~/.zsh_history:/root/.zsh_history  \
			-w /src/$(CUR_DIR) \
			--name local-tooling local-tooling

build:
	docker build -t local-tooling .

clean:
	docker container rm local-tooling || true
	docker image rm local-tooling || true
