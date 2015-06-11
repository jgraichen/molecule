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

    @state.index    = 0
    @state.uniqueId = util.uniqueId()

  onResize: (e) =>
    @forceUpdate()

  getValue: =>
    @props.items[@state.index]

  prepare: (props) =>
    super props

    props.classList.push 'm-select'

    props['aria-haspopup'] = true
    props['aria-controls'] = @state.uniqueId
    props['aria-expanded'] = @state.expanded

    props.onMouseDown = do (original = props.onMouseDown) =>
      (e) =>
        @setState expanded: !@state.expanded

  renderLayer: =>
    return unless @state.expanded

    target = React.findDOMNode @
    style  = minWidth: target.offsetWidth

    $ Attachment,
      style: style
      target: target
      constraints: [{ to: 'window', pin: true }]
      targetAttachment: 'top left'
      offset: =>
        root = document.getElementById @state.uniqueId
        item = document.getElementById "#{@state.uniqueId}-#{@state.index}"

        offset = item.offsetTop - root.offsetTop

        "#{offset}px 0"
      onCloseRequest: =>
        @setState expanded: false
      $ Panel, id: @state.uniqueId,
        $ Menu.List, null, do =>
          @renderItem item, index for item, index in @props.items

  renderItem: (item, index) =>
    $ Menu.Item,
      id: @state.uniqueId + '-' + index
      key: index,
      onAction: (e) =>
        e.preventDefault()
        @setState index: index, expanded: false, =>
          React.findDOMNode(@).focus()
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
