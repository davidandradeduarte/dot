install_type?=basic

ubuntu:
	docker build -t ubuntu-$(install_type)-dotfiles --build-arg install_type=$(install_type) -f envs/Dockerfile.ubuntu .
	docker run -it --rm ubuntu-$(install_type)-dotfiles

fedora:
	docker build -t fedora-$(install_type)-dotfiles --build-arg install_type=$(install_type) -f envs/Dockerfile.fedora .
	docker run -it --rm fedora-$(install_type)-dotfiles

.PHONY: ubuntu fedora