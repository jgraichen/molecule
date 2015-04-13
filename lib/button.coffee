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

      props['role'] = 'button'
      props['aria-disabled'] = !!@props.disabled

    if @props.href?
      $ 'a', props, @props.children
    else
      $ 'button', props, @props.children

module.exports = Button
