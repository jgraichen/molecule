#
React = require 'react'
$ = React.createElement

Prepare = require './mixin/prepare'
Extendible = require './mixin/extendible'

Transform = require './extensions/transform'
MaxLength = require './extensions/max-length'

module.exports = React.createClass
  displayName: 'Molecule.Input'
  mixins: [Prepare, Extendible]
  extensions: [MaxLength, Transform]

  render: ->
    props = @prepare (props, classList) =>
      classList.push 'molecule'
      classList.push 'input'

    $ 'input', props, props.children
