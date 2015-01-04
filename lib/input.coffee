#
React = require 'react'
$ = React.createElement

Focus = require './mixin/focus'
Prepare = require './mixin/prepare'
Extendible = require './mixin/extendible'

Transform = require './extensions/transform'
MaxLength = require './extensions/max-length'

module.exports = React.createClass
  displayName: 'Molecule.Input'
  mixins: [
    Prepare()
    Extendible()
    Focus(ref: 'input')
  ]
  extensions: [
    MaxLength()
    Transform()
  ]

  render: ->
    props = @prepare (props, classList) =>
      classList.push 'molecule'
      classList.push 'input'
      classList.push 'focus' if @state.focus

    className = props.className
    delete props.className

    props.ref = 'input'

    $ 'div', className: className,
      $ 'input', props
      props.children
