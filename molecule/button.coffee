#
React = require 'react'
$ = React.createElement

Button = React.createClass
  displayName: 'Molecule.Button'

  render: ->
    props = {}
    props[k] = v for k, v of @props

    props.className ?= ''
    props.className += ' molecule-button'

    $ 'button', props, @props.children

module.exports = Button
