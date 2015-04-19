#
React = require 'react'
$ = React.createElement

Resizable = require './mixins/resizable'
Layered = require './mixins/layered'

Attachment = require './attachment'
Button = require './button'
Panel = require './panel'

class Select extends Button
  @include Layered
  @include Resizable

  constructor: (props) ->
    super props

    @state.index = 0

  onResize: (e) =>
    @forceUpdate()

  prepare: (props) =>
    super props

    props.classList.push 'm-select'
    props.classList.push 'active' if @state.active

    props.onMouseDown = do (original = props.onMouseDown) =>
      (e) =>
        @setState active: !@state.active

  renderLayer: =>
    return unless @state.active

    target = React.findDOMNode @
    style  = minWidth: target.offsetWidth

    $ Attachment,
      style: style
      target: target
      onCloseRequest: =>
        @setState active: false
      $ Panel, null,
        $ 'ul', null, @props.children.map (item) =>
          $ 'li', null, item

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
