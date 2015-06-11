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
        (e) ->
          if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey && e.button == BUTTON_LEFT
            props.onAction e
          original? e

      props.onKeyPress = do (original = props.onKeyPress) =>
        (e) ->
          if !e.altKey && !e.ctrlKey && !e.metaKey && !e.shiftKey && e.keyCode == KEY_ENTER
            props.onAction e
          original? e

  renderComponent: (props) ->
    $ 'a', props, props.children

module.exports = Link
