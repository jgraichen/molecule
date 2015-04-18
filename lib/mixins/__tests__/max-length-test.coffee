Test = require '../../test'
Input = require '../../input'

describe 'MaxLength', ->
  it 'should invoke callback when maxlength is reached', ->
    spy = jasmine.createSpy 'onMaxLength'
    doc = Test.render ($) ->
      $ Input, onMaxLength: spy, maxLength: 3
    inp = doc.findByTag 'input'

    inp.dom.value = 'abc dh'
    inp.change()

    expect(spy).toHaveBeenCalled()
