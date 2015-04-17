jest.dontMock '../test'
jest.dontMock '../input'

Test = require '../test'
Input = require '../input'

describe 'Input', ->
  describe 'value', ->
    it 'handle initial value', ->
      doc = Test.render ($) -> $ Input, defaultValue: 'val'
      inp = doc.findByTag 'input'

      expect(inp.dom.value).toEqual 'val'

  describe 'CSS classes', ->
    it 'handles className', ->
      doc = Test.render ($) -> $ Input, className: 'a b'
      inp = doc.findByClass 'm-input'

      expect(inp.dom.className).toEqual 'a b m-input'

    it 'handles classList', ->
      doc = Test.render ($) -> $ Input, classList: ['a', 'b']
      inp = doc.findByClass 'm-input'

      expect(inp.dom.className).toEqual 'a b m-input'
