type?=full
local?=false
shell?=""

ubuntu:
	docker build -t ubuntu-$(type)-dotfiles \
		--build-arg type_arg=$(type) \
		--build-arg local:arg=$(local) \
		--build-arg shell_arg=$(shell) \
	-f envs/Dockerfile.ubuntu .
	docker run -it --rm ubuntu-$(type)-dotfiles

fedora:
	docker build -t fedora-$(type)-dotfiles \
		--build-arg type_arg=$(type) \
		--build-arg local_arg=$(local) \
		--build-arg shell_arg=$(shell) \
	-f envs/Dockerfile.fedora .
	docker run -it --rm fedora-$(type)-dotfiles

.PHONY: ubuntu fedora