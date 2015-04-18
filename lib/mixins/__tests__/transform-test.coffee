Test = require '../../test'
Input = require '../../input'

describe 'Transform', ->
  it 'should transform value on change', ->
    doc = Test.render ($) ->
      $ Input, transform: (value) -> value.toUpperCase()
    inp = doc.findByTag 'input'

    inp.dom.value = 'abc dh'
    inp.change()

    expect(inp.dom.value).toEqual 'ABC DH'
