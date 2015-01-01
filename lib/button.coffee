#
React = require 'react'
$ = React.createElement

Button = React.createClass
  displayName: 'Molecule.Button'

  render: ->
    props = className: ''
    props[k] = v for k, v of @props

    cs = props.className.split /\s+/
    cs.push 'molecule'
    cs.push 'button'
    cs.push 'primary' if @props.primary

    props.className = cs.join(' ').trim()

    tag = if @props.href then 'a' else 'button'

    $ tag, props, @props.children


ButtonGroup = React.createClass
  displayName: 'Molecule.ButtonGroup'

  render: ->
    props = {}
    props[k] = v for k, v of @props

    props.className ?= ''
    props.className += ' molecule'
    props.className += ' buttongroup'

    $ 'div', props, @props.children

module.exports =
  Button: Button
  ButtonGroup: ButtonGroup
