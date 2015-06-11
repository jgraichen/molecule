#
React = require 'react'
$ = React.createElement

Component = require './component'

class Link extends Component
  @defaultProps =
    href: '#'
    role: 'link'
    tabIndex: 0

  focus: =>
    React.findDOMNode(this).focus()

  prepare: (props) ->
    super props

    props.classList.push 'm-focus' if @state.focus
    props.classList.push 'm-active' if @state.active || @props.active
    props.classList.push 'm-hover' if @state.hover || @props.hover

    if props.onAction?
      props.onClick = do (original = props.onClick) =>
        (event) ->
          if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey && event.button == 0
            props.onAction event
          original? event

      props.onKeyPress = do (original = props.onKeyPress) =>
        (event) ->
          if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey && event.keyCode == 13
            props.onAction event
          original? event

  renderComponent: (props) ->
    $ 'a', props, props.children

module.exports = Link
