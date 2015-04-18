React = require 'react/addons'
TestUtils = React.addons.TestUtils

Test =
  render: (fn) ->
    new Test.Element React.addons.TestUtils.renderIntoDocument fn(React.createElement)

class Test.Element
  constructor: (component) ->
    @component = component

    Object.defineProperty @, 'dom', get: => component.getDOMNode()
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
