{RouterMixin} = require('react-mini-router')

{navigate} = require('react-mini-router')

config = require('../env.coffee')

Firebase = require('firebase')
Firebase.initializeApp(config)

module.exports = React.createFactory React.createClass
  displayName: "App"

  getInitialState: ->
    loggedIn: !!Firebase.auth().currentUser

  setLoginState: ->
    @setState loggedIn: !@state.loggedIn

  logout: ->
    console.log "logout"
    Firebase.auth().signOut()
    @setLoginState()

  mixins: [RouterMixin]

  routes: require('../config/routes')

  render: ->
    @renderCurrentRoute()

  main: (authCode, userName) ->
    if @state.loggedIn
      require('./components/main/index')
        authCode: authCode
        userName: userName
        firebase: Firebase
        logout: @logout
    else
      navigate("/", false)
      require('./components/login/fb_login')
        firebase: Firebase
        setLoginState: @setLoginState

  login: ->
    require('./components/login/fb_login')
      firebase: Firebase
      setLoginState: @setLoginState

  setup: (userName) ->
    if @state.loggedIn
      require('./components/login/index')
        firebase: Firebase
        userName: userName
        logout: @logout
    else
      navigate("/", false)
      require('./components/login/fb_login')
        firebase: Firebase
        setLoginState: @setLoginState
