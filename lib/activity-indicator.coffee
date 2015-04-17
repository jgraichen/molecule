#
React = require 'react'
$ = React.createElement

css = require './util/css'

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
    console.log @state

    props.classList.push 'm-activity-indicator'

    if @state.tasks > 0
      props.classList.push 'm-active'
      props.children.push 'Loading...'

  renderComponent: (props) ->
    $ 'span',
      className: props.className,
      style:
        width: props.size,
        height: props.size
      props.children


module.exports = ActivityIndicator
