React = require 'react/addons'
TestUtils = React.addons.TestUtils

Test =
  render: (fn) ->
    new Test.Document React.addons.TestUtils.renderIntoDocument fn(React.createElement)

class Test.Document
  constructor: (html) ->
    @html = html

  findByTag: (tagName) ->
    new Test.Element TestUtils.findRenderedDOMComponentWithTag @html, tagName

  findByClass: (cssClass) ->
    new Test.Element TestUtils.findRenderedDOMComponentWithClass @html, cssClass

class Test.Element
  constructor: (component) ->
    @component = component

    Object.defineProperty @, 'dom', get: => component.getDOMNode()

for fname, _ of TestUtils.Simulate
  do (fn = fname) =>
    if !Test.Element::[fn]?
      Test.Element::[fn] = (event = {}) ->
        TestUtils.Simulate[fn](@component, event)

module.exports = Test
