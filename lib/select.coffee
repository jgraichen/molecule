#
React = require 'react'
$ = React.createElement

Layered = require './mixins/layered'

Attachment = require './attachment'
Button = require './button'

class Select extends Button
  @include Layered

  constructor: (props) ->
    super props

    @state.index = 0

  prepare: (props) =>
    super props

    props.classList.push 'm-select'

    props.onMouseDown = (original = props.onMouseDown) =>
      (e) =>
        e.preventDefault()
        @setState open: true

  renderLayer: =>
    return unless @state.open

    $ Attachment, target: React.findDOMNode(@), [
      'Text'
    ]

  renderChildren: (props) =>
    children = []

    if @state.index < 0
      children.push props.placeholder
    else
      children.push props.children[@state.index]

    children.push $ 'span', className: 'm-handle'
    children

class Select.Item extends React.Component
  render: =>
    $ 'span', null, @props.children

module.exports = Select
