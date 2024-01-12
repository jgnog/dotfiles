SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

all:
	ls -d */ | xargs stow --no-folding -R -t ${HOME}
