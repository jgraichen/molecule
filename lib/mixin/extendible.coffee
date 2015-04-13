# The `Extendible` mixin allows to define extensions as
# component field or property that will be applied usually
# when rendering.
#

_extensions = (fn) ->
  if @extensions
    fn ext for ext in @extensions

  if @props.extensions
    fn ext for ext in @props.extensions

_enabled = (self, ext, props) ->
  ext.enabled && (ext.enabled == true || ext.enabled.call(self, props))

module.exports = ->
  componentDidMount: ->
    _extensions.call this, (ext) =>
      if ext.componentDidMount? && _enabled(this, ext)
        ext.componentDidMount.call this

  componentDidUpdate: ->
    _extensions.call this, (ext) =>
      if ext.componentDidUpdate? && _enabled(this, ext)
        ext.componentDidUpdate.call this

  componentWillUnmount: ->
    _extensions.call this, (ext) =>
      if ext.componentWillUnmount? && _enabled(this, ext)
        ext.componentWillUnmount.call this

  applyExtensions: (props) ->
    _extensions.call this, (ext) =>
      ext.apply.call this, props if _enabled @, ext, props
