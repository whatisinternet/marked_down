{div, ul, li, nav, a, input, i}  = React.DOM

config = require('../../../env.coffee')

marked = require('marked')

Firebase = require('firebase')
Firebase.initializeApp(config)

Keys = require('../../mixins/keys.coffee')
Code = require('./code.coffee')
Display = require('./display.coffee')
Nav = require('../nav/index.coffee')

CodeMixin = require('../../mixins/code-mixin.coffee')
FullScreenMixin = require('../../mixins/fullscreen-mixin.coffee')
ReactFireMixin = require('reactfire')

module.exports = React.createFactory React.createClass
  displayName: "main:app"

  mixins: [
    CodeMixin,
    FullScreenMixin,
    Keys,
    ReactFireMixin
  ]

  getInitialState: ->
    code: localStorage.getItem("markedDownCode") || [""]
    fileName: localStorage.getItem("markedDownFileName") || "markedDown"
    keyBinding: localStorage.getItem("markedDownKeyBinding") || "vim"
    leftClass: "s12 l6"
    rightClass: "s12 l6"

  componentDidUpdate: ->
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  componentDidMount: ->
    $('.dropdown-button').dropdown()
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  componentWillMount: ->
    ref = Firebase.database().ref().child("documents/#{@props.authCode}")
    @bindAsObject(ref, "code")

  componentWillUnmount: ->
    @unbind('code')

  render: ->
    code = @state.code['.value']


    div {},
      Nav
        fileSelected: @fileSelected
        vim: @vim
        emacs: @emacs
        sublime: @sublime
        openAttachment: @openAttachment
        toggleFullScreen: @toggleFullScreen
        downloadCode: @downloadCode
        downloadHTML: @downloadHTML
        downloadHTMLWrapped: @downloadHTMLWrapped
        authCode: @props.authCode


      div className: 'row',
        Code
          code: code
          updateCode: @updateCode
          leftClass: @state.leftClass
          keyBinding: @state.keyBinding

        Display
          rightClass: @state.rightClass
          code: code
