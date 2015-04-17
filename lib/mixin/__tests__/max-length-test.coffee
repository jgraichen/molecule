React = require 'react/addons'
Input = require '../../input'

$ = React.createElement
render = React.addons.TestUtils.renderIntoDocument
findTag = React.addons.TestUtils.findRenderedDOMComponentWithTag
findCss = React.addons.TestUtils.findRenderedDOMComponentWithClass
Simulate = React.addons.TestUtils.Simulate

describe 'MaxLength', ->
  it 'should invoke callback when maxlength is reached', ->
    spy   = jasmine.createSpy 'onMaxLength'

    # Should be included in Input by default
    html  = render $ Input, onMaxLength: spy, maxLength: 3
    input = findTag html, 'input'

    do (el = input.getDOMNode()) ->
      el = input.getDOMNode()
      el.value = 'abc dh'

      Simulate.change input, target: el

    expect(spy).toHaveBeenCalled()
