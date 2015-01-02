#
React = require 'react'
$ = React.createElement

Input = React.createClass
  displayName: 'Molecule.Input'

  render: ->
    props = className: ''
    props[k] = v for k, v of @props

    cs = props.className.split /\s+/
    cs.push 'molecule'
    cs.push 'input'
    props.className = cs.join(' ').trim()

    $ 'input', props, @props.children

module.exports = Input
