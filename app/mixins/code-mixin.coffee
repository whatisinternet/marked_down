marked = require('marked')
marked.setOptions(
  renderer: new marked.Renderer()
  gfm: true
  tables: true
  smartLists: true
  smartypants: true
)

module.exports =

  slimUser: ->
    user = @props.user
    {
      uid: user.uid
      email: user.email
      photo: user.photoURL
    }

  updateCode: (updateable) ->
    @updateFirebase(updateable)
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  downloadCode: ->
    targetElement = document.getElementById("dlCode")
    code = @state.code['.value']
    file = new Blob([code], type: "text/plain")
    targetElement.href = URL.createObjectURL(file)
    targetElement.download = "#{@state.fileName}.md"

  downloadHTML: ->
    targetElement = document.getElementById("dlHTML")
    code = @state.code['.value']
    if code?
      file = new Blob([marked(code)], type: "text/plain")
      targetElement.href = URL.createObjectURL(file)
      targetElement.download = "#{@state.fileName}.html"

  downloadHTMLWrapped: ->
    targetElement = document.getElementById("dlHTMLWrapped")
    code = @state.code['.value']
    if code?
      file = new Blob([@wrapHtml(marked(code), @state.fileName)], type: "text/plain")
      targetElement.href = URL.createObjectURL(file)
      targetElement.download = "#{@state.fileName}.html"

  openAttachment: ->
    fileInput = document.getElementById('openable-file')
    fileInput.click()

  updateFirebase: (code) ->
    users = @state.code.users
    active_users = @state.code.active_users || []
    if users?
      @firebaseRefs
        .code
        .update(
          document: code
          users: _.uniq users.concat(@props.user.uid)
          active_users: _.uniq active_users.concat(@slimUser()), 'uid'
          updated_at: (new Date()).toISOString()
          created_at: @state.code.created_at || (new Date()).toISOString()
          , =>)
    else
      @firebaseRefs
        .code
        .update(
          document: code
          users: [@props.user.uid]
          active_users: [@slimUser()]
          updated_at: (new Date()).toISOString()
          created_at: @state.code.created_at || (new Date()).toISOString()
          , =>)


  fileSelected: (inputFile) ->
    fileInput = document.getElementById('openable-file')
    f = fileInput.files[0]
    fr = new FileReader()
    fr.readAsText(f)
    fr.onload = (e) =>
      fileName =  f.name.split('.')
      localStorage.setItem("markedDownFileName", fileName[0])
      @updateFirebase(e.target.result)
      @setState {
        fileName: fileName[0]
      }

  wrapHtml: (inner, fileName) ->
   """
    <!DOCTYPE html>
    <html>
      <head>
        <meta charset="UTF-8">
        <meta id="meta-theme-color" name="theme-color" content="#000">
        <title>#{fileName}</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/css/materialize.min.css">
        <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.97.6/js/materialize.min.js"></script>
      </head>
      <body class="blue-grey lighten-5">
        <div class="container white">
          <div class="row" style="padding: 2em; margin-top: 2em">
            #{inner}
          </div>
        </div>
      </body>
    </html>
    """

