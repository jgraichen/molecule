#
#
React = require 'react'
$ = React.createElement

ActivityIndicator = require '../activity-indicator'
Attachment = require '../attachment'
Layered = require './layered'
Panel = require '../panel'
Menu = require '../menu'

_renderItem = (render, item, index) ->
  $ Menu.Item,
    key: index,
    onClick: (e) =>\
      @setState value: item.value, _acItems: null, _acDisabled: true, =>
        @focus()
        @setState _acDisabled: false
    render item

_renderPanel = (render) ->
  if @state._acItems?.length > 0
    $ Panel, null,
      $ Menu.List, null, do =>
        for item, index in @state._acItems
          _renderItem.call @, render, item, index

module.exports = (config) ->
  componentDidMount: ->
    @_acLayer ?= new Layered.Layer =>
      target = React.findDOMNode @
      style  = minWidth: target.offsetWidth

      $ Attachment,
        style: style
        target: target
        onCloseRequest: => @setState _acItems: null
        _renderPanel.call @, config.render

    @_acLayer.mount()

  componentDidUpdate: ->
    @_acLayer.update()

  componentWillUnmount: ->
    @_acLayer.unmount()

  prepare: (props) ->
    updateItems = (orig) =>
      (e) =>
        unless @state._acDisabled
          config.query(e.target.value).then (items) =>
            if @state.focus
              @setState _acItems: items
        orig? e

    props.onChange = do (orig = props.onChange) => updateItems orig
    props.onFocus = do (orig = props.onFocus) => updateItems orig
    props.onClick = do (orig = props.onClick) => updateItems orig
