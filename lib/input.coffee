#
React = require 'react'
$ = React.createElement

Component = require './component'

Extendible = require './mixin/extendible'
Prepare = require './mixin/prepare'
Focus = require './mixin/focus'

Transform = require './extensions/transform'
MaxLength = require './extensions/max-length'
Indicator = require './extensions/indicator'

class Input extends Component
  @include Prepare
  @include Extendible
  @include Focus, ref: 'input'

  extensions: [
    MaxLength()
    Transform()
  ]

  render: ->
    props = @prepare (props, classList) =>
      props.ref = 'input'
      props.key = 'input'

      props.classList.push 'm-input'
      props.classList.push 'focus' if @state.focus

    className = props.className
    delete props.className

    $ 'div', className: className, [
      $ 'input', props, []
      $ 'span', key: 'ext', className: 'm-input-ext', props.children
    ]


module.exports = Input
