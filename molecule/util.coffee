cx = (xs...) ->
  classes = []

  for x in xs
    switch typeof x
      when "string"
        classes.push z for z in x.split /\s+/
      when "object"
        for k, v of x
          classes.push k if v

  classes.join ' '

merge = (xs...) ->
  if xs?.length > 0
    tap {}, (m) -> m[k] = v for k, v of x for x in xs

tap = (o, fn) -> fn(o); o

module.exports =
  merge: merge
  tap: tap
  cx: cx
