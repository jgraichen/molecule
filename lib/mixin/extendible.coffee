#
Extendible =
  applyExtensions: ->
    if @extensions
      for ext in @extensions
        ext.apply.apply(this, arguments)

    if @props.extensions
      for ext in @props.extensions
        ext.apply.apply(this, arguments)

module.exports = Extendible
