#
React = require 'react'
$ = React.createElement

Component = require './component'

{BUTTON_LEFT, KEY_ENTER} = require './constants'

class Link extends Component
  @defaultProps =
    href: '#'
    role: 'link'
    tabIndex: 0

  focus: =>
    React.findDOMNode(this).focus()

  prepare: (props) ->
    super props

    if props.onAction?
      props.onClick = do (original = props.onClick) =>
        (event) ->
          if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey && event.button == BUTTON_LEFT
            props.onAction event
          original? event

      props.onKeyPress = do (original = props.onKeyPress) =>
        (event) ->
          if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey && event.keyCode == KEY_ENTER
            props.onAction event
          original? event

  renderComponent: (props) ->
    $ 'a', props, props.children

module.exports = Link
