#
React = require 'react'
$ = React.createElement

Component = require './component'

class Link extends Component
  prepare: (props) ->
    super props

    props.classList.push 'm-active' if props.active

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
