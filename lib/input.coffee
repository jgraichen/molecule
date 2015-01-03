#
React = require 'react'
$ = React.createElement

Extendible = require './mixin/extendible'

__extensions = []

Input = React.createClass
  displayName: 'Molecule.Input'
  mixins: [Extendible]
  extensions: __extensions

  render: ->
    props = className: ''
    props[k] = v for k, v of @props

    cs = props.className.split /\s+/
    cs.push 'molecule'
    cs.push 'input'
    props.className = cs.join(' ').trim()

    @applyExtensions props

    $ 'input', props, @props.children

# The OnMaxLength extensions extends Input to provide a
# onMaxLength callback that will be triggered when the maxLength
# is reached.
#
Input.OnMaxLength =
  apply: (props) ->
    props.onChange = do (orig = props.onChange) =>
      (e) =>
        if @props.onMaxLength && @props.maxLength && e.target.value.length >= @props.maxLength
          @props.onMaxLength e
        orig? e

__extensions.push Input.OnMaxLength

# The Transform extension uses a transform prop function to
# transform the entered value continuously.
Input.Transform =
  apply: (props) ->
    props.onChange = do (orig = props.onChange) =>
      (e) =>
        if @props.transform
          e.target.value = @props.transform e.target.value
        orig? e

__extensions.push Input.Transform

module.exports = Input
