function allup --description 'upgrade all the things!'
  brewup
  gem update
  npm update -g
end
