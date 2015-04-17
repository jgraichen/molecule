jest.dontMock '../test'
jest.dontMock '../link'

Test = require '../test'
Icon = require '../icon'

describe 'Icon', ->
  it 'has CSS classes', ->
    doc = Test.render ($) -> $ Icon, glyph: 'arrow'
    lnk = doc.findByTag 'i'

    expect(lnk.dom.className).toEqual 'm-icon fa fa-arrow'

  it 'has data glyph', ->
    doc = Test.render ($) -> $ Icon, glyph: 'arrow'
    lnk = doc.findByTag 'i'

    expect(lnk.dom.getAttribute('data-glyph')).toEqual 'arrow'
