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

  main: (authCode, user) ->
    if @state.loggedIn
      require('./components/main/index')
        authCode: authCode
        user: JSON.parse(atob(user))
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

  setup: (user) ->
    if @state.loggedIn
      require('./components/login/index')
        firebase: Firebase
        user: JSON.parse(atob(user))
        logout: @logout
    else
      navigate("/", false)
      require('./components/login/fb_login')
        firebase: Firebase
        setLoginState: @setLoginState
