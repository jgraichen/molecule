#
React = require 'react'
$ = React.createElement

Component = require './component'

Prepare = require './mixin/prepare'
Extendible = require './mixin/extendible'

class Button extends Component
  @include Prepare
  @include Extendible

  render: ->
    props = @prepare (props) =>
      props.classList.push 'm-button'
      props.classList.push 'm-primary' if @props.primary
      props.classList.push 'm-active' if @props.active

      props.tabIndex ?= 0
      props.role ?= 'button'

      props['aria-disabled'] = !!@props.disabled

      props.onClick = do (onClick = props.onClick) =>
        (event) ->
          if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey && event.button == 0
            props.onPrimary? event
          onClick? event

      props.onKeyPress = do (onKeyPress = props.onKeyPress) =>
        (event) ->
          if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey && event.keyCode == 13
            props.onPrimary? event
          onKeyPress? event

    component = @props.component || if @props.href? then 'a' else 'button'
    $ component, props, @props.children

module.exports = Button
