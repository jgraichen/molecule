#
Tether = require 'tether'
React = require 'react'
ReactDOM = require 'react-dom'
_ = require './prelude'
$ = React.createElement

class Attachment extends React.Component
  componentDidMount: =>
    @root = document.createElement 'DIV'
    document.body.appendChild @root

    document.addEventListener 'mousedown', @handleEvent
    document.addEventListener 'focus', @handleEvent, true

    ReactDOM.render @renderAttachment(), @root, =>
      @tether = new Tether
        classPrefix: 'm'
        element: @root
        target: _.value @props.target
        offset: _.value @props.offset || '0 0'
        attachment: _.value @props.attachment || 'top left'
        constraints: _.value @props.constraints
        targetOffset: _.value @props.targetOffset || '0 0'
        optimizations: _.value @props.optimizations
        targetModifier: _.value @props.targetModifier
        targetAttachment: _.value @props.targetAttachment || 'bottom left'
      @tether.position()

  componentDidUpdate: =>
    ReactDOM.render @renderAttachment(), @root, => @tether?.position()

  componentWillUnmount: =>
    ReactDOM.unmountComponentAtNode @root

    @tether.destroy?()
    document.body.removeChild @root
    document.removeEventListener 'mousedown', @handleEvent
    document.removeEventListener 'focus', @handleEvent, true

  handleEvent: (e) =>
    node = e.target

    while node != null
      return true if node == @root || node == @props.target
      node = node.parentNode

    @props.onCloseRequest?()
    true

  render: =>
    null

  renderAttachment: =>
    props = _.clone @props

    delete props.target
    delete props.offset
    delete props.attachment
    delete props.constraints
    delete props.targetOffset
    delete props.optimizations
    delete props.onCloseRequest
    delete props.targetModifier
    delete props.targetAttachment

    $ 'div', props

module.exports = Attachment
