React = require 'react'
ReactDOM = require 'react-dom'

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
      ReactDOM.render content, @_layerNode
    else
      ReactDOM.unmountComponentAtNode @_layerNode

class Layered.Layer
  constructor: (render) ->
    @render = render

  mount: =>
    @layerNode = document.createElement 'div'
    document.body.appendChild @layerNode

    @update()

  unmount: =>
    ReactDOM.unmountComponentAtNode @layerNode

  update: =>
    content = @render()

    if content
      ReactDOM.render content, @layerNode
    else
      ReactDOM.unmountComponentAtNode @layerNode

module.exports = Layered
