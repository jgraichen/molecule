#
React = require 'react'
$ = React.createElement

Link = require './link'

Sized = require './mixins/sized'

class Button extends Link
  @include Sized

  @defaultProps =
    role: 'button'
    tabIndex: 0

  prepare: (props) =>
    super props

    props['aria-disabled'] = !!props.disabled

    props.classList.push 'm-button'
    props.classList.push 'm-primary' if props.primary

    props.component ?= if props.href? then 'a' else 'button'

  renderComponent: (props) =>
    {component} = props
    delete props.component

    $ component, props, @renderChildren props

  renderChildren: (props) =>
    props.children

module.exports = Button
