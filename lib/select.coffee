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

{BUTTON_LEFT, KEY_UP, KEY_DOWN} = require './constants'

class Select extends Button
  @include Layered
  @include Resizable

  constructor: (props) ->
    super props

    @state.index     = 0
    @state.highlight = 0
    @state.uniqueId  = util.uniqueId()

  onResize: (e) =>
    @forceUpdate()

  getValue: =>
    @props.items[@state.index]

  _setIndex: (index, fn) =>
    index = 0 if index < 0
    index = @props.items.length - 1 if index >= @props.items.length

    @setState index: index, highlight: index, fn

  _collapse: (index) =>
    @_setIndex index if index?
    @setState expanded: false, => @focus()

  _expand: =>
    @setState expanded: true

  _toggle: =>
    if @state.expanded
      @_collapse()
    else
      @_expand()

  prepare: (props) =>
    super props

    props.classList.push 'm-select'

    props['aria-haspopup'] = true
    props['aria-controls'] = @state.uniqueId
    props['aria-expanded'] = @state.expanded

    props.onClick = do (original = props.onClick) =>
      (e) =>
        if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey && e.button == BUTTON_LEFT
          e.preventDefault()
          @_toggle()
        original? e

    props.onMouseDown = do (original = props.onMouseDown) =>
      (e) =>
        if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey && e.button == BUTTON_LEFT
          e.preventDefault()
          @focus()
          @_toggle()
        original? e

    props.onKeyDown = do (original = props.onKeyDown) =>
      (e) =>
        if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey
          if e.keyCode == KEY_UP
            e.preventDefault()
            @_setIndex @state.index - 1
          if e.keyCode == KEY_DOWN
            e.preventDefault()
            @_setIndex @state.index + 1
        original? e

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
        @_collapse @state.index
      $ Panel, id: @state.uniqueId,
        $ Menu.List, hover: 'manual', do =>
          @renderItem item, index for item, index in @props.items

  renderItem: (item, index) =>
    $ Menu.Item,
      id: @state.uniqueId + '-' + index
      key: index,
      highlight: @state.highlight == index
      onMouseOver: (e) =>
        @setState highlight: index
      onMouseUp: (e) =>
        if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey && e.button == BUTTON_LEFT
          if @state.index != index
            e.preventDefault()
            @_collapse index
      onClick: (e) =>
        if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey && e.button == BUTTON_LEFT
          e.preventDefault()
          @_collapse index

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
