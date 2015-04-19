React = require 'react'

#
Layered = ->
  componentDidMount: ->
    @_layer ?= new Layered.Layer @renderLayer
    @_layer.mount()

  componentDidUpdate: ->
    @_layer.update()

  componentWillUnmount: ->
    @_layer.unmount()

  _renderLayer: ->
    content = @renderLayer()

    if content
      React.render content, @_layerNode
    else
      React.unmountComponentAtNode @_layerNode

class Layered.Layer
  constructor: (render) ->
    @render = render

  mount: =>
    @layerNode = document.createElement 'div'
    document.body.appendChild @layerNode

    @update()

  unmount: =>
    React.unmountComponentAtNode @layerNode

  update: =>
    content = @render()

    if content
      React.render content, @layerNode
    else
      React.unmountComponentAtNode @layerNode

module.exports = Layered
