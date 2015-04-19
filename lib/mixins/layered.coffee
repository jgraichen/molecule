React = require 'react'

#
module.exports = ->
  componentDidMount: ->
    @_layerNode = document.createElement 'div'
    document.body.appendChild @_layerNode

    @_renderLayer()

  componentDidUpdate: ->
    @_renderLayer()

  componentWillUnmount: ->
    React.unmountComponentAtNode @_layerNode

  _renderLayer: ->
    content = @renderLayer()

    if content
      React.render content, @_layerNode
    else
      React.unmountComponentAtNode @_layerNode

