{div, input, label, h4, p}  = React.DOM

navigate = require('react-mini-router').navigate

module.exports = React.createFactory React.createClass
  displayName: "fb::login"

  getInitialState: ->
    loggedIn: !!@props.loggedIn

  componentWillMount: ->
    @props.firebase.auth().onAuthStateChanged((user) =>
      docCode = localStorage.getItem( "doc" )
      if user
        @setState loggedIn: true

        if docCode? && docCode != ""
          navigate "/#{docCode}/#{btoa(JSON.stringify(user))}"
        else
          navigate "/#{btoa(JSON.stringify(user))}"
    )

  login: ->
    provider = new @props.firebase.auth.GoogleAuthProvider();
    provider.addScope("https://www.googleapis.com/auth/plus.login")
    @props
      .firebase
      .auth()
      .signInWithPopup(provider)
      .then((result) =>
        token = result.credential.accessToken
        user = result.user
        navigate "/#{btoa(JSON.stringify(user))}"

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
    div className: "grey darken-4",
      div
        className: "red darken-2 z-depth-4 hoverable"
        style: {
          display: "flex"
          flexDirection: "column"
          alignItems: "center"
          justifyContent: "flex-end"
          height: "80vh"
        }
        h4
          className: "white-text"
          style: {
            marginBottom: "0em"
          },
          "# MarkedDown"
        p
          className: "grey-text text-lighten-3",
          "A live preview Markdown editor with firebase"
      div
        style:
          display: "flex"
          flexDirection: "column"
          alignItems: "center"
          justifyContent: "flex-start"
          height: "20vh",
        div
          className: "row center-align white-text"
          style: {
            marginTop: "2em"
          },
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
                    className: 'btn red darken-2',
                    "Login with google"
