#!/bin/bash

sh <(curl -L https://nixos.org/nix/install) --darwin-use-unencrypted-nix-store-volume
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install


