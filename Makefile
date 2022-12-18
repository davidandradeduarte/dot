INSTALL_TYPE?=full
LOCAL?=false
START_SHELL?=""

ubuntu:
	docker build -t ubuntu-$(INSTALL_TYPE)-dotfiles \
		--build-arg INSTALL_TYPE_ARG=$(INSTALL_TYPE) \
		--build-arg LOCAL_ARG=$(LOCAL) \
		--build-arg START_SHELL_ARG=$(START_SHELL) \
	-f envs/Dockerfile.ubuntu .
	docker run -it --rm ubuntu-$(INSTALL_TYPE)-dotfiles

fedora:
	docker build -t fedora-$(INSTALL_TYPE)-dotfiles \
		--build-arg INSTALL_TYPE_ARG=$(INSTALL_TYPE) \
		--build-arg LOCAL_ARG=$(LOCAL) \
		--build-arg START_SHELL_ARG=$(START_SHELL) \
	-f envs/Dockerfile.fedora .
	docker run -it --rm fedora-$(INSTALL_TYPE)-dotfiles

.PHONY: ubuntu fedora