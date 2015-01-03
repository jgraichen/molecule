#
React = require 'react'
$ = React.createElement

Prepare = require './mixin/prepare'
Extendible = require './mixin/extendible'

__extensions = []

Input = React.createClass
  displayName: 'Molecule.Input'
  mixins: [Prepare, Extendible]
  extensions: __extensions

  render: ->
    props = @prepare (props, classList) =>
      classList.push 'molecule'
      classList.push 'input'

    console.log props

    $ 'input', props, props.children

# The OnMaxLength extensions extends Input to provide a
# onMaxLength callback that will be triggered when the maxLength
# is reached.
#
Input.OnMaxLength =
  enabled: ->
    @props.onMaxLength && @props.maxLength

  apply: (props) ->
    props.onChange = do (original = props.onChange) =>
      (e) =>
        @props.onMaxLength e if e.target.value.length >= @props.maxLength
        original? e

__extensions.push Input.OnMaxLength

# The Transform extension uses a transform prop function to
# transform the entered value continuously.
#
Input.Transform =
  enabled: ->
    @props.transform?

  apply: (props) ->
    props.onChange = do (original = props.onChange) =>
      (e) =>
        e.target.value = @props.transform e.target.value
        original? e

__extensions.push Input.Transform

module.exports = Input
