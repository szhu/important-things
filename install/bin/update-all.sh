#!/bin/bash
cd "$(dirname "${BASH_SOURCE[0]}")"

brew leaves > ../brew.txt
brew cask list > ../brew-cask.txt
./appstore-list.sh > ../appstore.txt
./npm-list-leaves.sh > ../npm.txt
 sort < ~/.gem-prune > ../gem.txt
./pip-list-library-only.sh 2.7 > ../pip.txt
./pip-freeze.sh 3 > ../pip3.txt
