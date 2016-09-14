{div, ul, li, nav, a, input, i}  = React.DOM

marked = require('marked')
navigate = require('react-mini-router').navigate

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
    code:
      document: ""
      users: []
      active_users: []
      created_at: (new Date()).toISOString()
      updated_at: (new Date()).toISOString()
    fileName: localStorage.getItem("markedDownFileName") || "markedDown"
    keyBinding: localStorage.getItem("markedDownKeyBinding") || "vim"
    leftClass: "s12 l6"
    rightClass: "s12 l6"
    users: []

  componentDidUpdate: ->
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  componentDidMount: ->
    $('.dropdown-button').dropdown()
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  logoutWrapper: ->
    active_users = @state.code.active_users || []
    active_users = active_users[0...-1] if active_users.length > 0
    @firebaseRefs
      .code
      .update(
        created_at: (new Date()).toISOString()
        active_users: active_users
      , =>)
    @props.logout()

  changeRoomsWrapper: ->
    active_users = @state.code.active_users || []
    active_users = active_users[0...-1] if active_users.length > 0
    @firebaseRefs
      .code
      .update(
        created_at: (new Date()).toISOString()
        active_users: active_users
      , =>)
    try
      @unbind('code')
    localStorage.setItem( "doc", "")
    navigate "/#{btoa(JSON.stringify(@props.user))}", true

  componentWillMount: ->
    ref = @props
      .firebase
      .database()
      .ref()
      .child("documents/#{@props.authCode}")
    @bindAsObject(ref, "code")
    new_document = @state.code['.value']?
    slim_user = @props.user
    if new_document
      @firebaseRefs
        .code
        .update(
          document: ""
          created_at: (new Date()).toISOString()
          active_users: [@slimUser()]
          , =>)

  componentWillUnmount: ->
    try
      @unbind('code')

  render: ->
    code = @state.code.document

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
        logout: @logoutWrapper
        user: @props.user
        changeRooms: @changeRoomsWrapper
        active_users: @state.code.active_users


      div className: 'row',
        Code
          code: code || ""
          updateCode: @updateCode
          leftClass: @state.leftClass
          keyBinding: @state.keyBinding

        Display
          rightClass: @state.rightClass
          code: code || ""
