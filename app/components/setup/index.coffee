{div, input, label, h5, table, thead, tbody, tr, th, td, a}  = React.DOM

navigate = require('react-mini-router').navigate
uuid = require('uuid-v4')
moment = require('moment')

module.exports = React.createFactory React.createClass
  displayName: "login"

  getInitialState: ->
    user: btoa(JSON.stringify(@props.user))
    newDocument: true
    documentEnabled: true
    docCode: ""
    projects: []

  componentWillMount: ->
    @userDocuments()

  userDocuments: ->
    ref = @props
      .firebase
      .database()
      .ref("documents")
      .on('value', (snapshot) =>
        if @state.projects.length == 0
          documents = snapshot.val()
          keys = _.keys documents
          selection = _.select keys, (key) =>
            _.includes documents[key].users, @props.user.uid
          projects = _.reduce selection, ((accum, selected) =>
            accum.concat(_.extend documents[selected], {key: selected})
          ), []
          @setState projects: _.sortBy projects, 'updated_at', 'desc'
      )

  newRoute: ->
    date = new Date()
    window
      .btoa(
        uuid() + uuid()
      )[0..10]

  existingDocument: ->
    @setState newDocument: !@state.newDocument

  docCode: (e) ->
    docCode = e.target.value
    localStorage.setItem( "doc", docCode)
    @setState docCode: docCode

  navigateNewRoute: ->
    roomCode = @newRoute()
    localStorage.setItem( "doc", roomCode )
    navigate "/#{roomCode}/#{@state.user}"

  render: ->
    div
      className: "grey darken-3"
      style:
        display: "flex"
        alignItems: "center"
        justifyContent: "center"
        height: "100vh",
      div className: "row center-align white-text",
        div className: "row",
          if !@state.newDocument
            div {},
              h5 {},
                "Please select a room or enter a room code you have been given"
              div
                className: "row",
                  table {},
                    thead {},
                      tr {},
                        th {},
                          "Room Code"
                        th {},
                          "Date updated"
                    tbody {},
                      _.map @state.projects, (project) =>
                        tr key: project.key,
                          td
                            className: "white-text"
                            style: cursor: "pointer"
                            onClick: _.partial(navigate, "/#{project.key}/#{@state.user}"),
                              "Room: #{project.key}"
                          td {},
                            moment(project.updated_at).fromNow()
              div
                className: "row",
                div className: "input-field",
                  input
                    onKeyUp: @docCode
                    type: "text"
                    id: "docCode"
                  label
                    htmlFor: "docCode",
                      "Room code"
          div className: "row",
            div className: "col s6",
              div
                onClick: _.partial navigate, "/#{@state.docCode}/#{@state.user}"
                style: if @state.newDocument || !@state.documentEnabled then {display: "none"} else {display: ""}
                className: "btn-flat yellow",
                  "Open"
            div className: "col s6",
              div
                onClick: _.partial @existingDocument
                style: if @state.newDocument then {display: "none"} else {display: ""}
                className: "btn-flat yellow",
                  "Cancel"
            if @state.newDocument && @state.documentEnabled
              div {},
                div
                  className: "row center-align",
                  div className: "col s12",
                    div
                      onClick: _.partial @navigateNewRoute
                      style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                      className: "btn-flat yellow",
                        "New Document"
                div
                  className: "row center-align",
                  div className: "col s12",
                    div
                      onClick: _.partial @existingDocument
                      style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                      className: "btn-flat yellow accent-2",
                        "Existing Document"
