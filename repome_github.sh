#!/usr/bin/env zsh
set -xe
if [ ! -d repos ]; then
	mkdir repos
fi
cd repos
git clone git@github.com:fjelltopp/meerkat_dev.git
git clone git@github.com:mixmixmix/config.git
git clone git@github.com:mixmixmix/moreyfirth.git
git clone git@github.com:mixmixmix/parrtraks.git
git clone git@github.com:mixmixmix/thesis.git
git clone git@github.com:mixmixmix/moovemoo.git



