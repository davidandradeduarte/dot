install_type?=basic

ubuntu:
	docker build -t ubuntu-dotfiles -f envs/Dockerfile.ubuntu .
	docker run -it --rm ubuntu-dotfiles

ubuntu-basic:
	docker build -t ubuntu-basic-dotfiles --build-arg install_type=$(install_type) -f envs/Dockerfile.ubuntu .
	docker run -it --rm ubuntu-basic-dotfiles

fedora:
	docker build -t fedora-dotfiles -f envs/Dockerfile.fedora .
	docker run -it --rm fedora-dotfiles

fedora-basic:
	docker build -t fedora-basic-dotfiles --build-arg install_type=$(install_type) -f envs/Dockerfile.fedora .
	docker run -it --rm fedora-basic-dotfiles

macos:
	echo "Unsupported"

arch:
	echo "Unsupported"

.PHONY: ubuntu ubuntu-basic fedora fedora-basic macos arch