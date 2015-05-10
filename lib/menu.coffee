#
React = require 'react'
$ = React.createElement

Component = require './component'
Link = require './link'

Focus = require './mixins/focus'

class Menu extends Component
  prepare: (props) =>
    super props

    props.classList.push 'm-menu'

  renderComponent: (props) =>
    $ 'div', props, props.children

class Menu.List extends Component
  prepare: (props) =>
    super props

    props.classList.push 'm-menu-list'

  renderComponent: (props) =>
    $ 'ul', props, props.children

class Menu.Item extends Component
  @include Focus

  @defaultProps =
    href: '#'
    role: 'button'
    tabIndex: -1

  prepare: (props) =>
    super props

    props.ref = '1'
    props.classList.push 'focus' if @state.focus

    props.onMouseMove = do (ref = props.ref, original = props.onMouseMove) =>
      (e) =>
        React.findDOMNode(@refs[ref]).focus?()
        original? e

  renderComponent: (props) =>
    $ 'li',
      className: 'm-menu-item'
      $ Link, props, props.children

module.exports = Menu
