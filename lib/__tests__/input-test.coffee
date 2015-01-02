jest.dontMock '../input'

React = require 'react/addons'
Input = require '../input'

$ = React.createElement
render = React.addons.TestUtils.renderIntoDocument
findTag = React.addons.TestUtils.findRenderedDOMComponentWithTag
findCss = React.addons.TestUtils.findRenderedDOMComponentWithClass

describe 'Input', ->
  it 'should have CSS classes', ->
    html  = render $ Input, className: 'custom foo', defaultValue: 'Input Value'
    input = findTag html, 'input'

    expect(input.getDOMNode().className).toEqual('custom foo molecule input');
    expect(input.getDOMNode().value).toEqual('Input Value');
