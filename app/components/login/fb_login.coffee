{div, input, label, h1}  = React.DOM

navigate = require('react-mini-router').navigate

module.exports = React.createFactory React.createClass
  displayName: "fb::login"

  getInitialState: ->
    loggedIn: !!@props.firebase.auth().currentUser

  #TODO REDUX this
  login: ->
    provider = new @props.firebase.auth.GoogleAuthProvider();
    provider.addScope("https://www.googleapis.com/auth/plus.login")
    @props.firebase.auth().signInWithPopup(provider)
      .then((result) =>
        token = result.credential.accessToken
        user = result.user
        navigate "/#{user.displayName}"

        @setState loggedIn: true
        @props.setLoginState()
      )
        .catch((error) =>
          console.error error
        )

  logout: ->
    if @props.firebase.auth().currentUser
      @props.firebase.auth().signOut()
      @setState loggedIn: false
      @props.setLoginState()

  render: ->
    div
      style:
        display: "flex"
        flexDirection: "column"
        alignItems: "center"
        justifyContent: "center"
        height: "100vh",
      div className: "row center-align white-text",
        div className: "white-text",
          div
            className: "row center-align",
              if @state.loggedIn
                div
                  onClick: @logout
                  className: 'btn',
                  "Logout"
              else
                div
                  onClick: @login
                  className: 'btn red accent-2',
                  "Login with google"
