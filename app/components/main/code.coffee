{div} = React.DOM

Codemirror = require('react-codemirror')
CodeMirror = React.createFactory(Codemirror)
require("codemirror/mode/markdown/markdown")
require("codemirror/mode/xml/xml")
require("codemirror/theme/material.css")
require("codemirror/keymap/vim")
require("codemirror/keymap/emacs")
require("codemirror/keymap/sublime")
require("codemirror/addon/edit/closebrackets")
require("codemirror/addon/edit/matchbrackets")
require("codemirror/addon/edit/closetag")
require("codemirror/addon/edit/continuelist")
require("codemirror/addon/hint/show-hint")
require("codemirror/addon/hint/anyword-hint")

module.exports = React.createFactory React.createClass
  displayName: "index"

  render: ->
    options =
      lineNumbers: true
      mode: 'markdown'
      keyMap: @props.keyBinding
      theme: 'material'
      autofocus: true

    div className: "col #{@props.leftClass}",
      div className: 'blue-grey darken-4',
        CodeMirror
          ref: "editor"
          value: @props.code
          onChange: @props.updateCode
          options: options
