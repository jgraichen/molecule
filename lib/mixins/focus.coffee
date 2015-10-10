React = require 'react'
ReactDOM = require 'react-dom'

#
module.exports = (config = {}) ->
  componentDidMount: ->
    @__focusHandler = => @setState focus: true
    @__blurHandler = => @setState focus: false

    if config.ref
      node = ReactDOM.findDOMNode @refs[config.ref]
    else
      node = ReactDOM.findDOMNode @

    node.addEventListener 'focus', @__focusHandler
    node.addEventListener 'blur', @__blurHandler

  componentWillUnmount: ->
    if config.ref
      node = ReactDOM.findDOMNode @refs[config.ref]
    else
      node = ReactDOM.findDOMNode @

    node.removeEventListener 'focus', @__focusHandler
    node.removeEventListener 'blur', @__blurHandler
