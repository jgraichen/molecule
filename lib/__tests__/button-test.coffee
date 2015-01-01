jest.dontMock '../button'

React = require 'react/addons'
{Button, ButtonGroup} = require '../button'

$ = React.createElement
render = React.addons.TestUtils.renderIntoDocument
findTag = React.addons.TestUtils.findRenderedDOMComponentWithTag
findCss = React.addons.TestUtils.findRenderedDOMComponentWithClass

describe 'Button', ->
  it 'should have CSS classes', ->
    html = render $ Button, className: 'custom foo', 'Button text'
    btn  = findTag html, 'button'

    expect(btn.getDOMNode().className).toEqual('custom foo molecule button');

  it 'should have primary class', ->
    html = render $ Button, primary: true, 'Button text'
    btn  = findTag html, 'button'

    expect(btn.getDOMNode().className).toContain('primary');

  it 'should render with given content', ->
    html = render $ Button, null, 'Button text'
    btn  = findTag html, 'button'

    expect(btn.getDOMNode().textContent).toEqual('Button text');

  it 'should render anchor if href given', ->
    html = render $ Button, href: '/#', 'Button text'
    btn  = findTag html, 'a'

    expect(btn.getDOMNode().textContent).toEqual('Button text');
    expect(btn.getDOMNode().className).toEqual('molecule button');
    expect(btn.getDOMNode().href).toEqual('file:///#');

describe 'ButtonGroup', ->
  it 'should render correctly', ->
    html = render $ ButtonGroup, className: 'custom foo',
      $ Button, null, 'Button A'
      $ Button, null, 'Button B'
    btn  = findCss html, 'buttongroup'

    expect(btn.getDOMNode().className).toEqual('custom foo molecule buttongroup');
    expect(btn.getDOMNode().children.length).toEqual(2);

    for tag in btn.getDOMNode().children
      expect(tag.tagName).toEqual('BUTTON')

