function gem-uninstall-everything --description 'uninstall all the gems!'
  for gem in (gem list --no-versions)
    echo gem uninstall -aIx $gem
    gem uninstall -aIx $gem
  end
end
