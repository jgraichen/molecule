#
React = require 'react'
$ = React.createElement

Prepare = require './mixin/prepare'
Extendible = require './mixin/extendible'

module.exports = React.createClass
  displayName: 'Molecule.Button'
  mixins: [Prepare, Extendible]

  render: ->
    props = @prepare (props, classList) =>

      classList.push 'molecule'
      classList.push 'button'
      classList.push 'primary' if @props.primary

      props['role'] = 'button'
      props['aria-disabled'] = !!@props.disabled

      if @props.href
        props.tagName = 'A'
      else
        props.tagName = 'BUTTON'

    $ props.tagName, props, props.children
