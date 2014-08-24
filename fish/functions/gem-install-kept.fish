function gem-install-kept --description 'install all the kept gems!'
  set -l gems (cat ~/.gem-prune)
  echo gem install $gems
  gem install $gems
end
