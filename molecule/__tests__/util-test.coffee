Util = require '../util'

describe 'Util', ->
  describe '#merge', ->
    it 'should merge objects', ->
      a = a: 1
      b = b: 2

      expect Util.merge a, b
        .toEqual a: 1, b: 2
