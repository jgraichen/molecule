React = require 'react'
ReactDOM = require 'react-dom'
Molecule = require './index'

module.exports =
  render: (root, fn) ->
    root = document.querySelector root
    elem = fn React.createElement, Molecule

    ReactDOM.render elem, root
