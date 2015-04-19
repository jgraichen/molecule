jest.dontMock '../button'
jest.dontMock '../test'

Test = require '../test'
Button = require '../button'

describe 'Button', ->
  it 'should have CSS classes', ->
    doc = Test.render ($) ->
      $ Button, className: 'custom foo', 'Button text'

    btn = doc.findByTag 'button'

    expect(btn.dom.className).toEqual('custom foo m-button');

  it 'should have primary class', ->
    doc = Test.render ($) ->
      $ Button, primary: true, 'Button text'

    btn = doc.findByTag 'button'

    expect(btn.dom.className).toContain('m-primary');

  it 'should have title attr', ->
    doc = Test.render ($) ->
      $ Button, title: 'Title text', 'Button text'

    btn = doc.findByTag 'button'

    expect(btn.dom.title).toEqual('Title text');

  it 'should render with given content', ->
    doc = Test.render ($) ->
      $ Button, null, 'Button text'

    btn = doc.findByTag 'button'

    expect(btn.dom.textContent).toEqual('Button text');

  it 'should render anchor if href given', ->
    doc = Test.render ($) ->
      $ Button, href: '/#', 'Button text'

    btn = doc.findByTag 'a'

    expect(btn.dom.textContent).toEqual('Button text');
    expect(btn.dom.className).toEqual('m-button');
    expect(btn.dom.href).toEqual('file:///#');

  it 'should invoke onAction on primary click', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.click button: 0

    expect(spy).toHaveBeenCalled()

  it 'should invoke onAction on enter press', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.keyPress keyCode: 13

    expect(spy).toHaveBeenCalled()

  it 'should not invoke onAction when clicked with ALT key', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.click altKey: true

    expect(spy).not.toHaveBeenCalled()

  it 'should not invoke onAction when clicked with META key', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.click metaKey: true

    expect(spy).not.toHaveBeenCalled()

  it 'should not invoke onAction when clicked with SHIFT key', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.click shiftKey: true

    expect(spy).not.toHaveBeenCalled()

  it 'should not invoke onAction when clicked with CTRL key', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.click ctrlKey: true

    expect(spy).not.toHaveBeenCalled()

  it 'should not invoke onAction when clicked with RIGHT button', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.click button: 1

    expect(spy).not.toHaveBeenCalled()

  it 'should not invoke onAction when clicked with MIDDLE button', ->
    spy = jasmine.createSpy 'onAction'
    doc = Test.render ($) ->
      $ Button, component: 'a', onAction: spy, 'Link text'

    btn = doc.findByTag 'a'
    btn.click button: 2

    expect(spy).not.toHaveBeenCalled()
