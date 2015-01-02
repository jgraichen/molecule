#
React = require 'react'
$ = React.createElement

Group = React.createClass
  displayName: 'Molecule.Group'

  render: ->
    props = className: ''
    props[k] = v for k, v of @props

    cs = props.className.split /\s+/
    cs.push 'molecule'
    cs.push 'group'
    props.className = cs.join(' ').trim()

    $ 'div', props, @props.children

module.exports = Group
