#
React = require 'react'
$ = React.createElement

Component = require './component'

class ActivityIndicator extends Component
  @defaultProps = size: 15

  constructor: (props) ->
    super props
    @state = tasks: 0

  add: ->
    @setState tasks: @state.tasks + 1

  remove: ->
    @setState tasks: @state.tasks - 1 if @state.tasks > 0

  track: (promise) ->
    @add()

    promise.then(=> @remove()).catch(=> @remove())
    promise

  prepare: (props) ->
    super props

    props.classList.push 'm-activity-indicator'

    if @state.tasks > 0 || props.on
      props.classList.push 'm-active'
      props.children.push 'Loading...'

    props.style ?= {}
    props.style.width = props.size
    props.style.height = props.size

  renderComponent: (props) ->
    $ 'span', props


module.exports = ActivityIndicator
