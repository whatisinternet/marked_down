{RouterMixin} = require('react-mini-router')

{navigate} = require('react-mini-router')

config = require('../env.coffee')

Firebase = require('firebase')
Firebase.initializeApp(config)

module.exports = React.createFactory React.createClass
  displayName: "App"

  getInitialState: ->
    loggedIn: false

  setLoginState: (state = @state.loggedIn) ->
    try
      @setState loggedIn: !state

  componentWillMount: ->
    Firebase.auth().onAuthStateChanged((user) =>
      docCode = localStorage.getItem( "doc" )
      if user
        @setState loggedIn: true
    )

  logout: ->
    localStorage.setItem("doc", "")
    Firebase.auth().signOut()
    @setLoginState(true)

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
        loggedIn: @state.loggedIn

  login: ->
    require('./components/login/fb_login')
      firebase: Firebase
      setLoginState: @setLoginState
      loggedIn: @state.loggedIn

  setup: (user) ->
    if @state.loggedIn
      require('./components/setup/index')
        firebase: Firebase
        user: JSON.parse(atob(user))
        logout: @logout
    else
      navigate("/", false)
      require('./components/login/fb_login')
        firebase: Firebase
        setLoginState: @setLoginState
        loggedIn: @state.loggedIn
