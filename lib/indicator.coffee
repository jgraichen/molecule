#
React = require 'react'
$ = React.createElement

css = require './util/css'

Component = require './component'

class Indicator extends Component
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

  render: ->
    className = css @props.className,
      'm-spinner': true,
      'm-spinning': @state.tasks > 0

    text = ''
    text = 'Loading...' if @state.tasks > 0

    $ 'span', className: className, style: {width: @props.size, height: @props.size}, text


module.exports = Indicator
