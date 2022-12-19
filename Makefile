type?=full
local?=false
shell?=""
dir?="/home/david/.dotfiles"
ignore_errors?=false
no_confirm?=false

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

system:
	@if [ $(no_confirm) != true ]; then \
		echo "\033[0;33mWarning:\033[0m This is not a docker target. It will install dotfiles in your current system."; \
		read -p "Are you sure? [y/N] " ans && ans=$${ans:-N} ; \
		if [ $${ans} = y ] || [ $${ans} = Y ]; then \
			type=$(type) local=$(local) shell=$(shell) dir=$(dir) ignore_errors=$(ignore_errors) \
				./install.sh; \
		fi; \
		echo "\033[0m\c"; \
	else \
		type=$(type) local=$(local) shell=$(shell) dir=$(dir) ignore_errors=$(ignore_errors) \
			./install.sh; \
	fi


.PHONY: ubuntu fedora system