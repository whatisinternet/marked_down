{div, ul, li, nav, a, input, i}  = React.DOM

marked = require('marked')
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

CodeMixin = require('../../mixins/code-mixin.coffee')
Keys = require('../../mixins/keys.coffee')

module.exports = React.createFactory React.createClass
  displayName: "index"

  mixins: [CodeMixin]

  getInitialState: ->
    code: localStorage.getItem("markedDownCode") || ""
    fileName: localStorage.getItem("markedDownFileName") || "markedDown"
    keyBinding: localStorage.getItem("markedDownKeyBinding") || "vim"

  componentDidUpdate: ->
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  componentDidMount: ->
    $('.dropdown-button').dropdown()
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  render: ->

    options =
      lineNumbers: true
      mode: 'markdown'
      keyMap: @state.keyBinding
      theme: 'material'
      autofocus: true

    div {},
      input
        type: 'file'
        id: 'openable-file'
        style: {display: 'none'}
        onChange: _.bind(@fileSelected, @),
      ul
        id: "export-dropdown"
        className: 'dropdown-content',
          li {},
            a
              href: ''
              id: 'dlCode',
                "Code"
          li {},
            a
              href: ''
              id: 'dlHTML',
                "HTML"
          li {},
            a
              href: ''
              id: 'dlHTMLWrapped',
                "HTML wrapped"
      ul
        id: "code-type-dropdown"
        className: 'dropdown-content',
          li {},
            a
              href: ''
              onClick: @vim,
                "VIM"
          li {},
            a
              href: ''
              onClick: @emacs,
                "Emacs"
          li {},
            a
              href: ''
              onClick: @sublime,
                "Sublime"

      div className: 'navbar-fixed',
        nav className: 'grey darken-4',
          div className: "nav-wrapper",
            ul
              id: "nav-mobile"
              className: "left",
                li {},
                  a
                    onClick: @openAttachment
                    href: '',
                      "Open File"
                li {},
                  a
                    className: 'dropdown-button'
                    'data-activates': "export-dropdown",
                        "Export"
                li {},
                  a
                    className: 'dropdown-button'
                    'data-activates': "code-type-dropdown",
                        "Key bindings"

      div className: 'row',
        div className: 'col s12 l6',
          div className: 'card-panel blue-grey darken-4 hoverable',
            CodeMirror
              ref: "editor"
              value: @state.code
              onChange: @updateCode
              options: options

        div className: 'col s12 l6',
          div className: 'card-panel white blue-grey-text text-darken-4 hoverable',
            div dangerouslySetInnerHTML: __html: marked(@state.code)
