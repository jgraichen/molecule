#
React = require 'react'
$ = React.createElement

Component = require './component'
Link = require './link'

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
  prepare: (props) =>
    super props

    props.classList.push 'm-menu-item'

  renderComponent: (props) =>
    className = props.className
    delete props.className

    $ 'li',
      className: className
      $ Link, props, props.children

module.exports = Menu
