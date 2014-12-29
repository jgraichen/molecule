jest.dontMock '../button'

React = require 'react/addons'
Button = require '../button'

$ = React.createElement
render = React.addons.TestUtils.renderIntoDocument
findIn = React.addons.TestUtils.findRenderedDOMComponentWithTag

describe 'Button', ->
  it 'should have CSS classes', ->
    html = render $ Button, className: 'custom foo', 'Button text'
    btn  = findIn html, 'button'

    expect(btn.getDOMNode().className).toEqual('custom foo molecule-button');

  it 'should render with given content', ->
    html = render $ Button, null, 'Button text'
    btn  = findIn html, 'button'

    expect(btn.getDOMNode().textContent).toEqual('Button text');
