Test = require '../../test'
Input = require '../../input'

describe 'Submit', ->
  describe 'onBlur', ->
    it 'invokes onSubmit', ->
      spy = jasmine.createSpy 'onSubmit'
      doc = Test.render ($) -> $ Input, submitOnBlur: true, onSubmit: spy
      inp = doc.findByTag 'input'

      inp.dom.value = 'abc dh'
      inp.change()
      inp.blur()

      expect(spy).toHaveBeenCalledWith 'abc dh'

    it 'does not invoke without flag', ->
      spy = jasmine.createSpy 'onSubmit'
      doc = Test.render ($) -> $ Input, onSubmit: spy
      inp = doc.findByTag 'input'

      inp.dom.value = 'abc dh'
      inp.change()
      inp.blur()

      expect(spy).not.toHaveBeenCalled()
