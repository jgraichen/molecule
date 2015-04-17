jest.dontMock '../test'
jest.dontMock '../link'

Test = require '../test'
Link = require '../link'

describe 'Link', ->
  describe 'content', ->
    it 'handles component children', ->
      doc = Test.render ($) -> $ Link, null, 'Link text'
      lnk = doc.findByTag 'a'

      expect(lnk.dom.textContent).toEqual 'Link text'

  describe 'CSS classes', ->
    it 'handles className prop', ->
      doc = Test.render ($) -> $ Link, className: 'a b c'
      lnk = doc.findByTag 'a'

      expect(lnk.dom.className).toEqual 'a b c'

    it 'handles classList prop', ->
      doc = Test.render ($) -> $ Link, classList: ['a', 'c']
      lnk = doc.findByTag 'a'

      expect(lnk.dom.className).toEqual 'a c'

  describe 'onAction', ->
    describe 'onClick', ->
      it 'invokes on primary click', ->
        spy = jasmine.createSpy 'onAction'
        doc = Test.render ($) -> $ Link, onAction: spy
        lnk = doc.findByTag 'a'

        lnk.click button: 0

        expect(spy).toHaveBeenCalled()

      it 'does not invoke with modifier key', ->
        spy = jasmine.createSpy 'onAction'
        doc = Test.render ($) -> $ Link, onAction: spy
        lnk = doc.findByTag 'a'

        lnk.click altKey: true
        lnk.click metaKey: true
        lnk.click ctrlKey: true
        lnk.click shiftKey: true

        expect(spy).not.toHaveBeenCalled()

      it 'does not invoke with alternate button', ->
        spy = jasmine.createSpy 'onAction'
        doc = Test.render ($) -> $ Link, onAction: spy
        lnk = doc.findByTag 'a'

        lnk.click button: 1
        lnk.click button: 2

        expect(spy).not.toHaveBeenCalled()

    describe 'onKeyPress', ->
      it 'invokes on ENTER press', ->
        spy = jasmine.createSpy 'onAction'
        doc = Test.render ($) -> $ Link, onAction: spy
        lnk = doc.findByTag 'a'

        lnk.keyPress keyCode: 13

        expect(spy).toHaveBeenCalled()

      it 'does not invoke with modifier key', ->
        spy = jasmine.createSpy 'onAction'
        doc = Test.render ($) -> $ Link, onAction: spy
        lnk = doc.findByTag 'a'

        lnk.keyPress keyCode: 13, altKey: true
        lnk.keyPress keyCode: 13, metaKey: true
        lnk.keyPress keyCode: 13, ctrlKey: true
        lnk.keyPress keyCode: 13, shiftKey: true

        expect(spy).not.toHaveBeenCalled()

      it 'does not invoke with alternate key', ->
        spy = jasmine.createSpy 'onAction'
        doc = Test.render ($) -> $ Link, onAction: spy
        lnk = doc.findByTag 'a'

        lnk.keyPress keyCode: 14

        expect(spy).not.toHaveBeenCalled()

