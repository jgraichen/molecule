#
React = require 'react'
$ = React.createElement

Tether = require 'tether/tether'

module.exports = React.createClass
  displayName: 'Molecule.Attachment'

  getDefaultProps: ->
    attachment: 'top left'
    targetAttachment: 'bottom left'

  componentDidMount: ->
    @root = document.createElement 'DIV'
    document.body.appendChild @root

    document.addEventListener 'mousedown', @handleCloseRequest
    document.addEventListener 'focus', @handleCloseRequest, true

  handleCloseRequest: (e) ->
    return true unless @tether

    node = e.target

    while node != null
      return true if node == @root || node == @target
      node = node.parentNode

    @props.onCloseRequest?()
    true

  attachTo: (target) ->
    @target = target

    if @tether
      @tether.setOption target: target
    else
      @renderComponent()

      @tether = new Tether
        element: @root
        target: target
        attachment: @props.attachment
        constraints: @props.constraints
        targetAttachment: @props.targetAttachment

  componentDidUpdate: ->
    @renderComponent()
    @tether.position() if @tether

  componentWillUnmount: ->
    React.unmountComponentAtNode @root

    @tether.destroy()
    document.body.removeChild @__root
    document.removeEventListener 'mousedown', @handleCloseRequest
    document.removeEventListener 'focus', @handleCloseRequest

  renderComponent: ->
    if @props.children
      React.render @props.children, @root
    else
      React.unmountComponentAtNode @root

  render: -> null
