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

    props.onChange = (e) =>
      if @props.transform
        e.target.value = @props.transform e.target.value

      if @props.onMaxLength && @props.maxLength && e.target.value.length >= @props.maxLength
        @props.onMaxLength e

      if @props.onChange && !e.defaultPrevented
        @props.onChange e

    $ 'input', props, @props.children

module.exports = Input
