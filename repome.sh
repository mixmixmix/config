#!/usr/bin/env zsh
set -xe
if [ ! -d repos ]; then
	mkdir repos
fi
cd repos
git clone git@github.com:fjelltopp/meerkat_dev.git
