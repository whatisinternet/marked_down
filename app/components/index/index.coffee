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

module.exports = React.createFactory React.createClass
  displayName: "index"

  getInitialState: ->
    code: localStorage.getItem("markedDownCode") || ""
    fileName: localStorage.getItem("markedDownFileName") || "markedDown"
    keyBinding: localStorage.getItem("markedDownKeyBinding") || "vim"

  updateCode: (updateable) ->
    @setState code: updateable
    localStorage.setItem("markedDownCode", updateable)
    @downloadCode()
    @downloadHTML()

  downloadCode: ->
    targetElement = document.getElementById("dlCode")
    file = new Blob([@state.code], type: "text/plain")
    targetElement.href = URL.createObjectURL(file)
    targetElement.download = "#{@state.fileName}.md"

  downloadHTML: ->
    targetElement = document.getElementById("dlHTML")
    file = new Blob([marked(@state.code)], type: "text/plain")
    targetElement.href = URL.createObjectURL(file)
    targetElement.download = "#{@state.fileName}.html"

  openAttachment: ->
    fileInput = document.getElementById('openable-file')
    fileInput.click()

  fileSelected: (inputFile) ->
    fileInput = document.getElementById('openable-file')
    f = fileInput.files[0]
    fr = new FileReader()
    fr.readAsText(f)
    fr.onload = (e) =>
      fileName =  f.name.split('.')
      localStorage.setItem("markedDownCode", e.target.result)
      localStorage.setItem("markedDownFileName", fileName[0])
      @setState {
        code: e.target.result
        fileName: fileName[0]
      }

  componentDidUpdate: ->
    @downloadCode()
    @downloadHTML()

  componentDidMount: ->
    $('.dropdown-button').dropdown()
    @downloadCode()
    @downloadHTML()

  vim: ->
    localStorage.setItem("markedDownKeyBinding", 'vim')
    @setState keyBinding: 'vim'

  emacs: ->
    localStorage.setItem("markedDownKeyBinding", 'emacs')
    @setState keyBinding: 'emacs'

  sublime: ->
    localStorage.setItem("markedDownKeyBinding", 'sublime')
    @setState keyBinding: 'sublime'

  render: ->

    bem = new Bemmer(block: 'index')
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
          div className: 'card-panel blue-grey darken-4',
            CodeMirror
              ref: "editor"
              value: @state.code
              onChange: @updateCode
              options: options

        div className: 'col s12 l6',
          div className: 'card-panel white blue-grey-text text-darken-4',
            div dangerouslySetInnerHTML: __html: marked(@state.code)
