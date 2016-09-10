{RouterMixin} = require('react-mini-router')

{navigate} = require('react-mini-router')

config = require('../env.coffee')

Firebase = require('firebase')
Firebase.initializeApp(config)

module.exports = React.createFactory React.createClass
  displayName: "App"

  getInitialState: ->
    loggedIn: !(localStorage.getItem("doc") == "")

  setLoginState: (state = @state.loggedIn) ->
    @setState loggedIn: !state

  logout: ->
    localStorage.setItem("doc", "")
    Firebase.auth().signOut()
    @setLoginState(true)

  mixins: [RouterMixin]

  routes: require('../config/routes')

  render: ->
    if @state.loggedIn
      @renderCurrentRoute()
    else
      require('./components/login/fb_login')
        firebase: Firebase
        setLoginState: @setLoginState
        loggedIn: @state.loggedIn

  main: (authCode, user) ->
    if @state.loggedIn
      require('./components/main/index')
        authCode: authCode
        user: JSON.parse(atob(user))
        firebase: Firebase
        logout: @logout
    else
      navigate("/", true)
      div {}

  login: ->
    require('./components/login/fb_login')
      firebase: Firebase
      setLoginState: @setLoginState
      loggedIn: @state.loggedIn

  setup: (user) ->
    if @state.loggedIn
      require('./components/login/index')
        firebase: Firebase
        user: JSON.parse(atob(user))
        logout: @logout
    else
      navigate("/", true)
      div {}
