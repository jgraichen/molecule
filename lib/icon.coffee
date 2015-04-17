#
React = require 'react'
$ = React.createElement

Component = require './component'

class Icon extends Component
  @defaultProps:
    flip:
      horizontal: false
      vertical: false

  prepare: (props) ->
    super props

    props.classList.push 'm-icon'
    props.classList.push 'fa'
    props.classList.push 'fa-flip-vertical' if !props.flip.horizontal && props.flip.vertical
    props.classList.push 'fa-flip-horizontal' if props.flip.horizontal && !props.flip.vertical
    props.classList.push 'fa-flip-horizontal-vertical' if props.flip.horizontal && props.flip.vertical
    props.classList.push 'fa-fw' if props.fixedwidth || props.fw
    props.classList.push 'fa-lg' if props.large
    props.classList.push "fa-#{props.glyph}"

    props['data-glyph'] = props.glyph

  renderComponent: (props) ->
    $ 'i', props

module.exports = Icon
