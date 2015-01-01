jest.dontMock '../button'

React = require 'react/addons'
{Button, ButtonGroup} = require '../button'

$ = React.createElement
render = React.addons.TestUtils.renderIntoDocument
findIn = React.addons.TestUtils.findRenderedDOMComponentWithTag

describe 'Button', ->
  it 'should have CSS classes', ->
    html = render $ Button, className: 'custom foo', 'Button text'
    btn  = findIn html, 'button'

    expect(btn.getDOMNode().className).toEqual('custom foo molecule button');

  it 'should have primary class', ->
    html = render $ Button, primary: true, 'Button text'
    btn  = findIn html, 'button'

    expect(btn.getDOMNode().className).toContain('primary');

  it 'should render with given content', ->
    html = render $ Button, null, 'Button text'
    btn  = findIn html, 'button'

    expect(btn.getDOMNode().textContent).toEqual('Button text');

  it 'should render anchor if href given', ->
    html = render $ Button, href: '/#', 'Button text'
    btn  = findIn html, 'a'

    expect(btn.getDOMNode().textContent).toEqual('Button text');
    expect(btn.getDOMNode().className).toEqual('molecule button');
    expect(btn.getDOMNode().href).toEqual('file:///#');
