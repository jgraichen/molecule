#
React = require 'react'
$ = React.createElement

Component = require './component'

Focus = require './mixin/focus'
Transform = require './mixin/transform'
MaxLength = require './mixin/max-length'

class Input extends Component
  @include Focus, ref: 'input'
  @include MaxLength
  @include Transform

  prepare: (props) ->
    super props

    props.classList.push 'm-input'
    props.classList.push 'focus' if @state.focus

  renderComponent: (props) ->
    className = props.className
    delete props.className

    props.ref = 'input'
    props.key = 'input'

    $ 'div', className: className, [
      $ 'input', props, []
      $ 'span', key: 'ext', className: 'm-input-ext', props.children
    ]

module.exports = Input
