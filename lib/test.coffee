React = require 'react'
ReactDOM = require 'react-dom'
TestUtils = require 'react-dom/test-utils'

Test =
  render: (fn) ->
    new Test.Element TestUtils.renderIntoDocument fn(React.createElement)

class Test.Element
  constructor: (component) ->
    @component = component

    Object.defineProperty @, 'dom', get: => ReactDOM.findDOMNode(component)
    Object.defineProperty @, 'state', get: => component.state
    Object.defineProperty @, 'props', get: => component.props

  findByTag: (tagName) ->
    new Test.Element TestUtils.findRenderedDOMComponentWithTag @component, tagName

  findByClass: (cssClass) ->
    new Test.Element TestUtils.findRenderedDOMComponentWithClass @component, cssClass

for fname, _ of TestUtils.Simulate
  do (fn = fname) =>
    if !Test.Element::[fn]?
      Test.Element::[fn] = (event = {}) ->
        TestUtils.Simulate[fn](@component, event)

module.exports = Test
