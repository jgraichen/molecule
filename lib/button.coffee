#
React = require 'react'
$ = React.createElement

Link = require './link'

class Button extends Link
  prepare: (props) ->
    super props

    props.classList.push 'm-button'
    props.classList.push 'm-primary' if props.primary

    props.tabIndex ?= 0
    props.role ?= 'button'

    props['aria-disabled'] = !!props.disabled

    props.component ?= if props.href? then 'a' else 'button'

  renderComponent: (props) ->
    {component} = props

    $ component, props, props.children

module.exports = Button
