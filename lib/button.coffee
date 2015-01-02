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

    props['role'] = 'button'
    props['aria-disabled'] = !!@props.disabled

    tag = if @props.href then 'a' else 'button'

    $ tag, props, @props.children

module.exports = Button
