jest.dontMock '../test'
jest.dontMock '../group'

Test = require '../test'
Group = require '../group'

describe 'Group', ->
  it 'renders', ->
    doc = Test.render ($) -> $ Group
    grp = doc.findByTag 'div'

    expect(grp.dom.className).toEqual 'm-group'
