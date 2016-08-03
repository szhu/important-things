function newline-clearline
  echo -ne '\n\033[K'
end

function clearline
  echo -ne '\r\033[K'
end

function clearline-toend
  echo -ne '\033[K'
end
