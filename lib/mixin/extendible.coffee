# The `Extendible` mixin allows to define extensions as
# component field or property that will be applied usually
# when rendering.
#

_extensions = (fn) ->
  if @extensions
    fn ext for ext in @extensions

  if @props.extensions
    fn ext for ext in @props.extensions

_enabled = (ext, args) ->
  ext.enabled && (ext.enabled == true || ext.enabled.apply(this, args))

module.exports = ->
  componentDidMount: ->
    _extensions.call this, (ext) =>
      if ext.componentDidMount? && _enabled.call(this, ext)
        ext.componentDidMount.call this

  componentDidUpdate: ->
    _extensions.call this, (ext) =>
      if ext.componentDidUpdate? && _enabled.call(this, ext)
        ext.componentDidUpdate.call this

  componentWillUnmount: ->
    _extensions.call this, (ext) =>
      if ext.componentWillUnmount? && _enabled.call(this, ext)
        ext.componentWillUnmount.call this

  applyExtensions: (args...) ->
    _extensions.call this, (ext) =>
      ext.apply.apply this, args if _enabled.call(this, ext, args)
