marked = require('marked')
marked.setOptions(
  renderer: new marked.Renderer()
  gfm: true
  tables: true
  smartLists: true
  smartypants: true
)

module.exports =
  updateCode: (updateable) ->
    @firebaseRefs.code.push({
      updateable
    })

    localStorage.setItem("markedDownCode", updateable)
    @downloadCode()
    @downloadHTML()
    @downloadHTMLWrapped()

  downloadCode: ->
    targetElement = document.getElementById("dlCode")
    code = @state.code[@state.code?.length - 1]?.updateable
    file = new Blob([code], type: "text/plain")
    targetElement.href = URL.createObjectURL(file)
    targetElement.download = "#{@state.fileName}.md"

  downloadHTML: ->
    targetElement = document.getElementById("dlHTML")
    code = @state.code[@state.code?.length - 1]?.updateable
    if code?
      file = new Blob([marked(code)], type: "text/plain")
      targetElement.href = URL.createObjectURL(file)
      targetElement.download = "#{@state.fileName}.html"

  downloadHTMLWrapped: ->
    targetElement = document.getElementById("dlHTMLWrapped")
    code = @state.code[@state.code?.length - 1]?.updateable
    if code?
      file = new Blob([@wrapHtml(marked(code), @state.fileName)], type: "text/plain")
      targetElement.href = URL.createObjectURL(file)
      targetElement.download = "#{@state.fileName}.html"

  openAttachment: ->
    fileInput = document.getElementById('openable-file')
    fileInput.click()

  fileSelected: (inputFile) ->
    fileInput = document.getElementById('openable-file')
    f = fileInput.files[0]
    console.log f
    fr = new FileReader()
    fr.readAsText(f)
    fr.onload = (e) =>
      console.log f.name, e.target.result
      fileName =  f.name.split('.')
      localStorage.setItem("markedDownCode", e.target.result)
      localStorage.setItem("markedDownFileName", fileName[0])
      result = e.target.result
      @firebaseRefs.code.push({
        updateable: result
      })
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

