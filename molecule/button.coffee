#
React = require 'react'
{cx, merge} = require './util'

{button} = React.DOM

Button = React.createClass
  displayName: 'Molecule.Button'

  render: ->
    props = merge @props,
      className: cx @props.className,
        'molecule-button': true

    React.createElement 'button', props, @props.children

module.exports = Button
