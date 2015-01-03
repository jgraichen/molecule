# The `Extendible` mixin allows to define extensions as
# component field or property that will be applied usually
# when rendering.
#

tryExtension = (component, ext, args) ->
  if ext.enabled && (ext.enabled == true || ext.enabled.apply(component, args))
    ext.apply.apply(component, args)

module.exports =
  applyExtensions: (args...) ->
    if @extensions
      for ext in @extensions
        tryExtension this, ext, args

    if @props.extensions
      for ext in @props.extensions
        tryExtension this, ext, args
