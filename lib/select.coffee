#
React = require 'react'
$ = React.createElement

Component = require './component'

class Select extends Component
  constructor: (props) ->
    super props

    @state.index = 0

  prepare: (props) =>
    super props

    props.classList.push 'm-select'

  renderComponent: (props) =>
    $ 'button', props, @renderChildren props

  renderChildren: (props) =>
    if @state.index < 0
      props.placeholder
    else
      props.children[@state.index]

class Select.Item extends React.Component
  render: =>
    $ 'span', null, @props.children

module.exports = Select
