jest.dontMock '../input'

React = require 'react/addons'
Input = require '../input'

$ = React.createElement
render = React.addons.TestUtils.renderIntoDocument
findTag = React.addons.TestUtils.findRenderedDOMComponentWithTag
findCss = React.addons.TestUtils.findRenderedDOMComponentWithClass
Simulate = React.addons.TestUtils.Simulate

describe 'Input', ->
  it 'should have CSS classes', ->
    html  = render $ Input, className: 'custom foo', defaultValue: 'Input Value'
    input = findTag html, 'input'

    do (el = input.getDOMNode()) ->
      expect(el.parentNode.className).toEqual 'custom foo m-input'
      expect(el.value).toEqual 'Input Value'
