{div, ul, li, nav, a, input, i}  = React.DOM

marked = require('marked')

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
    code: ""
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
    ref = @props.firebase.database().ref().child("documents/#{@props.authCode}")
    @bindAsObject(ref, "code")

  componentWillUnmount: ->
    @unbind('code')

  render: ->
    code = if @state.code['.value']? then @state.code['.value'] else @state.code
    code = "" if code['.value'] == null

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
        logout: @props.logout
        user: @props.user



      div className: 'row',
        Code
          code: code || ""
          updateCode: @updateCode
          leftClass: @state.leftClass
          keyBinding: @state.keyBinding

        Display
          rightClass: @state.rightClass
          code: code || ""
