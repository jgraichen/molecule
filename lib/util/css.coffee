#
module.exports = (args...) ->
  classList = []

  for arg in args
    if typeof arg == 'string'
      classList.push m for m in arg.split /\s+/
    if typeof arg == 'object'
      if arg.className? || arg.classList?
        if arg.className?
          classList.push m for m in arg.className.split /\s+/
        if arg.classList?
          classList.push m for m in arg.classList
      else
        for cls, bool of arg
          classList.push cls if bool

  classList.join(' ').trim()
