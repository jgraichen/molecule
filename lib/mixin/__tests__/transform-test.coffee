React = require 'react/addons'
Input = require '../../input'

$ = React.createElement
render = React.addons.TestUtils.renderIntoDocument
findTag = React.addons.TestUtils.findRenderedDOMComponentWithTag
findCss = React.addons.TestUtils.findRenderedDOMComponentWithClass
Simulate = React.addons.TestUtils.Simulate

describe 'Transform', ->
  it 'should transform value on change', ->
    # Should be included in Input by default
    html  = render $ Input, transform: (value) -> value.toUpperCase()
    input = findTag html, 'input'

    do (el = input.getDOMNode()) ->
      el = input.getDOMNode()
      el.value = 'abc dh'

      Simulate.change input, target: el

    do (el = input.getDOMNode()) ->
      expect(el.value).toEqual 'ABC DH'
