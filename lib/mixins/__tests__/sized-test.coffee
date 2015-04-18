Test = require '../../test'
Input = require '../../input'

describe 'Sized', ->
  it 'shortest', ->
    doc = Test.render ($) ->
      $ Input, size: 'shortest'
    inp = doc.findByClass 'm-input'

    expect(inp.dom.className).toContain 'm-shortest'

  it 'shorter', ->
    doc = Test.render ($) ->
      $ Input, size: 'shorter'
    inp = doc.findByClass 'm-input'

    expect(inp.dom.className).toContain 'm-shorter'

  it 'short', ->
    doc = Test.render ($) ->
      $ Input, size: 'short'
    inp = doc.findByClass 'm-input'

    expect(inp.dom.className).toContain 'm-short'

  it 'default', ->
    doc = Test.render ($) ->
      $ Input, size: 'default'
    inp = doc.findByClass 'm-input'

    expect(inp.dom.className).toContain 'm-default'

  it 'long', ->
    doc = Test.render ($) ->
      $ Input, size: 'long'
    inp = doc.findByClass 'm-input'

    expect(inp.dom.className).toContain 'm-long'

  it 'longer', ->
    doc = Test.render ($) ->
      $ Input, size: 'longer'
    inp = doc.findByClass 'm-input'

    expect(inp.dom.className).toContain 'm-longer'

  it 'fluid', ->
    doc = Test.render ($) ->
      $ Input, size: 'fluid'
    inp = doc.findByClass 'm-input'

    expect(inp.dom.className).toContain 'm-fluid'

  it '<number>', ->
    doc = Test.render ($) ->
      $ Input, size: 5
    inp = doc.findByClass 'm-input'
    fin = doc.findByTag 'input'

    expect(inp.dom.className).toEqual 'm-input'
    expect(fin.dom.size).toEqual 5
