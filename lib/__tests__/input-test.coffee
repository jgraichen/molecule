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
      expect(el.className).toEqual 'custom foo molecule input'
      expect(el.value).toEqual 'Input Value'

describe 'Input.Transform', ->
  it 'should transform value on change', ->
    html  = render $ Input, transform: (value) -> value.toUpperCase()
    input = findTag html, 'input'

    do (el = input.getDOMNode()) ->
      el = input.getDOMNode()
      el.value = 'abc dh'

      Simulate.change input, target: el

    do (el = input.getDOMNode()) ->
      expect(el.value).toEqual 'ABC DH'

describe 'Input.OnMaxLength', ->
  it 'should invoke callback when maxlength is reached', ->
    spy   = jasmine.createSpy 'onMaxLength'
    html  = render $ Input, onMaxLength: spy, maxLength: 3
    input = findTag html, 'input'

    do (el = input.getDOMNode()) ->
      el = input.getDOMNode()
      el.value = 'abc dh'

      Simulate.change input, target: el

    expect(spy).toHaveBeenCalled()
