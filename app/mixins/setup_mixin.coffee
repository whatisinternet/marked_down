uuid = require('uuid-v4')
navigate = require('react-mini-router').navigate

module.exports =
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

