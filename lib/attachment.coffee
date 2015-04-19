#
React = require 'react'
$ = React.createElement

Tether = require 'tether/tether'

class Attachment
  constructor: (config) ->
    @config = config
    {@render, @target} = @config

    unless @render && typeof @render == 'function'
      throw new Error 'Attachment must have render function'

    unless @target
      throw new Error 'Attachment must have target'

    @root = document.createElement 'DIV'
    document.body.appendChild @root

    document.addEventListener 'mousedown', @handleCloseRequest
    document.addEventListener 'focus', @handleCloseRequest, true

    @tether = new Tether
      element: @root
      target: @target
      attachment: @config.attachment || 'top left'
      constraints: @config.constraints
      targetAttachment: @config.targetAttachment || 'bottom left'

    @update()

  handleCloseRequest: (e) =>
    node = e.target

    while node != null
      return true if node == @root || node == @target
      node = node.parentNode

    @config.onCloseRequest?()
    true

  update: =>
    content = @render()
    if content
      React.render content, @root, => @tether?.position()
    else
      React.unmountComponentAtNode @root

  destroy: =>
    React.unmountComponentAtNode @root

    @tether.destroy()
    document.body.removeChild @root
    document.removeEventListener 'mousedown', @handleCloseRequest
    document.removeEventListener 'focus', @handleCloseRequest

module.exports = Attachment
