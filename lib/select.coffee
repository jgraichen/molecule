#
React = require 'react'
$ = React.createElement

Attachment = require './attachment'
Resizable = require './mixins/resizable'
Layered = require './mixins/layered'
Button = require './button'
Panel = require './panel'
Menu = require './menu'
util = require './util'

class Select extends Button
  @include Layered
  @include Resizable

  constructor: (props) ->
    super props

    @state.index = 0

  onResize: (e) =>
    @forceUpdate()

  getValue: =>
    @props.items[@state.index]

  prepare: (props) =>
    super props

    props.classList.push 'm-select'

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
        $ Menu.List, null, do =>
          @renderItem item, index for item, index in @props.items

  renderItem: (item, index) =>
    $ Menu.Item,
      key: index,
      onClick: (e) =>
        if util.isPrimaryButton e
          e.preventDefault()
          @setState index: index
      @props.render item

  renderChildren: (props) =>
    children = []

    if @state.index < 0
      children.push props.placeholder
    else
      children.push @props.render props.items[@state.index]

    children.push $ 'span', className: 'm-handle'
    children

module.exports = Select
