{div, input, label, h5, table, thead, tbody, tr, th, td, a, img, hr}  = React.DOM

navigate = require('react-mini-router').navigate
moment = require('moment')
marked = require('marked')
SetupMixin = require('../../mixins/setup_mixin')

module.exports = React.createFactory React.createClass
  displayName: "login"

  mixins: [
    SetupMixin
  ]

  getInitialState: ->
    user: btoa(JSON.stringify(@props.user))
    newDocument: true
    documentEnabled: true
    docCode: ""
    projects: []
    document: ""

  previewDocument: (docCode) ->
    project = _.find @state.projects, key: docCode
    if project
      @setState document: project.document
    else
      @setState document: ""

  componentDidMount: ->
    @userDocuments()

  render: ->
    div className: "row",
      div
        className: "light-blue darken-4 col s1 m7 l7"
        style: { height: "100vh" }
        div
          className: "hide-on-small-only"
          style: {
            backgroundColor: "rgba(255, 255, 255, 0.5)"
            filter: "blur(2px)"
            WebkitFilter: "blur(2px)"
          },
          div dangerouslySetInnerHTML: __html: marked(@state.document)
      div
        className: "grey darken-4 col s11 m5 l5"
        style:
          display: "flex"
          alignItems: "flex-end"
          justifyContent: "flex-end"
          height: "100vh",
        div className: "row center-align white-text",
          div className: "row",
            if !@state.newDocument
              div {},
                div
                  className: "row",
                  div className: "input-field",
                    input
                      onKeyUp: @docCode
                      type: "text"
                      placeholder: "room code"
                      id: "roomCode",
                div className: "row",
                  div className: "col s6",
                    div
                      onClick: _.partial navigate, "/#{@state.docCode}/#{@state.user}"
                      style: if @state.newDocument || !@state.documentEnabled then {display: "none"} else {display: ""}
                      className: "btn-flat yellow accent-2",
                        "Open"
                  div className: "col s6",
                    div
                      onClick: _.partial @existingDocument
                      style: if @state.newDocument then {display: "none"} else {display: ""}
                      className: "btn-flat yellow accent-2",
                        "Cancel"

                div
                  className: "row",
                    hr {}

                div
                  className: "row",
                    table {},
                      thead {},
                        tr {},
                          th {},
                            "Code"
                          th {},
                            "Date updated"
                          th {},
                            "Active users"
                      tbody {},
                        if @state.projects.length == 0
                          tr {},
                            td {}
                            td {}
                            td {}
                        else
                          _.map @state.projects, (project) =>
                            tr
                              key: project.key
                              onMouseEnter: _.partial(@previewDocument, project.key)
                              onMouseLeave: _.partial(@previewDocument, "")
                              onClick: _.partial(navigate, "/#{project.key}/#{@state.user}")
                              style: cursor: "pointer",
                              td
                                className: "white-text",
                                  "#{project.key}"
                              td {},
                                moment(project.updated_at).fromNow()
                              td {},
                                _.map project.active_users, (user) ->
                                  img
                                    key: user.uid
                                    className: "circle responsive-img"
                                    style:
                                      width: '20px',
                                    src: user.photo
                                    alt: user.email
            div className: "row",
              if @state.newDocument && @state.documentEnabled
                div {},
                  div
                    className: "row center-align",
                    div className: "col s12",
                      div
                        onClick: _.partial @navigateNewRoute
                        style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                        className: "btn-flat yellow accent-2",
                          "New Document"
                  div
                    className: "row center-align",
                    div className: "col s12",
                      div
                        onClick: _.partial @existingDocument
                        style: if @state.newDocument && @state.documentEnabled then {display: ""} else {display: "none"}
                        className: "btn-flat yellow accent-2",
                          "Existing Document"
                  div
                    className: "row center-align",
                    div className: "col s12",
                      div
                        onClick: @props.logout,
                        className: "btn-flat red accent-2",
                          "Logout"
