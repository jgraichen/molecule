# The `Extendible` mixin allows to define extensions as
# component field or property that will be applied usually
# when rendering.
#

tryExtension = (component, ext, args) ->
  if ext?.enabled?.apply(component, args)
    ext.run?.apply(component, args)

Extendible =
  applyExtensions: ->
    if @extensions
      for ext in @extensions
        tryExtension this, ext, arguments

    if @props.extensions
      for ext in @props.extensions
        tryExtension this, ext, arguments

module.exports = Extendible
