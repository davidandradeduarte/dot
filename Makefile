type?=""
local?=""
shell?=""
dir?=""
ignore_errors?=""
no_confirm?=""

install:
	@if [ $(no_confirm) != true ]; then \
		echo "\033[0;33mWarning:\033[0m This is not a docker target. It will install dotfiles in your current system."; \
		read -p "Continue? [y/N] " ans && ans=$${ans:-N} ; \
		if [ $${ans} = y ] || [ $${ans} = Y ]; then \
			type=$(type) local=$(local) shell=$(shell) dir=$(dir) ignore_errors=$(ignore_errors) \
				./install.sh; \
		fi; \
		echo "\033[0m\c"; \
	else \
		type=$(type) local=$(local) shell=$(shell) dir=$(dir) ignore_errors=$(ignore_errors) \
			./install.sh; \
	fi

uninstall:
	@./uninstall.sh $(dir) $(no_confirm)

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

.PHONY: install ubuntu fedora