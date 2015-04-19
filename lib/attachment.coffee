#
Tether = require 'tether/tether'
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

    @update()

  componentWillUnmount: =>
    React.unmountComponentAtNode @root

    @tether.destroy()
    document.body.removeChild @root
    document.removeEventListener 'mousedown', @handleEvent
    document.removeEventListener 'focus', @handleEvent

  handleEvent: (e) =>
    node = e.target

    while node != null
      return true if node == @root || node == @target
      node = node.parentNode

    @props.onCloseRequest?()
    true

  update: =>
    React.render @renderAttachment(), @root, => @tether?.position()

  render: =>
    null

  renderAttachment: =>
    $ 'div', null, @props.children

module.exports = Attachment
