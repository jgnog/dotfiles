SHELL := /bin/bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c

all:
	ls -d */ | xargs stow --no-folding -R -t ${HOME}

first_stow:
	ls -d */ | xargs stow --adopt -t ${HOME} && git restore . && ls -d */ | xargs stow --no-folding -R -t ${HOME}
