type?=full
local?=false
shell?=""
dir?="/home/david/.dotfiles"
ignore_errors?=false

ubuntu:
	docker build -t ubuntu-$(type)-dotfiles \
		--build-arg type_arg=$(type) \
		--build-arg local_arg=$(local) \
		--build-arg shell_arg=$(shell) \
		--build-arg dir_arg=$(dir) \
		--build-arg ignore_errors_arg=$(ignore_errors) \
	-f envs/Dockerfile.ubuntu .
	docker run -it --rm ubuntu-$(type)-dotfiles

fedora:
	docker build -t fedora-$(type)-dotfiles \
		--build-arg type_arg=$(type) \
		--build-arg local_arg=$(local) \
		--build-arg shell_arg=$(shell) \
		--build-arg dir_arg=$(dir) \
		--build-arg ignore_errors_arg=$(ignore_errors) \
	-f envs/Dockerfile.fedora .
	docker run -it --rm fedora-$(type)-dotfiles

.PHONY: ubuntu fedora