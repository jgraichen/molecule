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
    delete props.hover

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

    props.classList.push 'm-highlight' if props.highlight

  renderComponent: (props) =>
    $ 'li',
      className: 'm-menu-item'
      $ Link, props, props.children

module.exports = Menu
