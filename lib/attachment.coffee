#
Tether = require 'tether/tether'
assign = require 'object-assign'
React = require 'react'
$ = React.createElement

class Attachment extends React.Component
  componentDidMount: =>
    @root = document.createElement 'DIV'
    document.body.appendChild @root

    document.addEventListener 'mousedown', @handleEvent
    document.addEventListener 'focus', @handleEvent, true

    @tether = new Tether
      element: @root
      target: @props.target
      attachment: @props.attachment || 'top left'
      constraints: @props.constraints
      targetAttachment: @props.targetAttachment || 'bottom left'

    @componentDidUpdate()

  componentDidUpdate: =>
    React.render @renderAttachment(), @root, => @tether?.position()

  componentWillUnmount: =>
    React.unmountComponentAtNode @root

    @tether.destroy()
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
    props = assign {}, @props

    delete props.target
    delete props.attachment
    delete props.constraints
    delete props.onCloseRequest
    delete props.targetAttachment

    $ 'div', props

module.exports = Attachment
