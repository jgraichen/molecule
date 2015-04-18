#
React = require 'react'
$ = React.createElement

Component = require './component'

Focus = require './mixins/focus'
Sized = require './mixins/sized'
Submit = require './mixins/submit'
Transform = require './mixins/transform'
MaxLength = require './mixins/max-length'

class Input extends Component
  @include Focus, ref: 'input'
  @include MaxLength
  @include Transform
  @include Submit
  @include Sized

  constructor: (props) ->
    super props

    @state.value = props.defaultValue

  getValue: =>
    @state.value

  setValue: (value) ->
    @setState value: value

  prepare: (props) ->
    super props

    props.classList.push 'm-input'
    props.classList.push 'focus' if @state.focus

    props.ref   = 'input'
    props.key   = 'input'
    props.value = @state.value

    props.onChange = do (original = props.onChange) =>
      (e) =>
        original? e
        @setState value: e.target.value

  renderComponent: (props) ->
    className = props.className
    delete props.className

    $ 'div', className: className, [
      $ 'span', key: 'ext', className: 'm-input-ext', props.children
      $ 'input', props, []
    ]

module.exports = Input
