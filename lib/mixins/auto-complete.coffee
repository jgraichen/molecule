#
#
React = require 'react'
$ = React.createElement

ActivityIndicator = require '../activity-indicator'
Attachment = require '../attachment'
Layered = require './layered'
Panel = require '../panel'
Menu = require '../menu'

{KEY_UP, KEY_DOWN, KEY_ENTER} = require '../constants'

_renderItem = (render, item, index) ->
  $ Menu.Item,
    key: index
    highlight: @state._acHighlight == index
    onMouseOver: (e) =>
      @setState _acHighlight: index
    onClick: (e) =>
      @setState value: item.value, _acItems: null, _acDisabled: true, =>
        @focus()
        @setState _acDisabled: false
    render item

_renderPanel = (render) ->
  if @state._acItems?.length > 0
    $ Panel, null,
      $ Menu.List, null, do =>
        for item, index in @state._acItems
          _renderItem.call this, render, item, index

module.exports = (config) ->
  componentDidMount: ->
    @_acLayer ?= new Layered.Layer =>
      target = React.findDOMNode this
      style  = minWidth: target.offsetWidth

      $ Attachment,
        style: style
        target: target
        onCloseRequest: => @setState _acItems: null
        _renderPanel.call this, config.render

    @_acLayer.mount()

  componentDidUpdate: ->
    @_acLayer.update()

  componentWillUnmount: ->
    @_acLayer.unmount()

  prepare: (props) ->
    updateItems = (orig) =>
      (e) =>
        if !@state._acHighlight?
          @setState _acHighlight: 0

        unless @state._acDisabled
          config.query(e.target.value).then (items) =>
            if @state.focus
              @setState _acItems: items
        orig? e

    props.onChange = do (orig = props.onChange) => updateItems orig
    props.onFocus = do (orig = props.onFocus) => updateItems orig
    props.onClick = do (orig = props.onClick) => updateItems orig

    props.onKeyDown = do (original = props.onKeyDown) =>
      (e) =>
        if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey
          if @state._acItems?.length > 0

            if e.keyCode == KEY_UP
              e.preventDefault()
              if @state._acHighlight > 0
                @setState _acHighlight: @state._acHighlight - 1
              else
                @setState _acHighlight: (@state._acItems.length - 1)

            if e.keyCode == KEY_DOWN
              e.preventDefault()
              if @state._acHighlight < (@state._acItems.length - 1)
                @setState _acHighlight: @state._acHighlight + 1
              else
                @setState _acHighlight: 0

            if e.keyCode == KEY_ENTER
              e.preventDefault()
              @setState value: @state._acItems[@state._acHighlight].value, _acItems: null, _acDisabled: true, =>
                @focus()
                @setState _acDisabled: false

        original? e
