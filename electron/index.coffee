electron = require('electron')
app = electron.app

WND_STATE =
  MINIMIZED: 0
  NORMAL: 1
  MAXIMIZED: 2
  FULL_SCREEN: 3

wndState = WND_STATE.NORMAL

@mainWindow = undefined

onClosed = () ->
  @mainWindow = null

createMainWindow = () ->
  win = new electron.BrowserWindow(
    width: 1920
    height: 1080
  )

  win.loadURL("file://#{__dirname}/index.html")
  win.on('closed', onClosed)
  win.setFullScreenable(true)
  win.setMaximizable(true)
  win

app.on('window-all-closed', () ->
  if process.platform != 'darwin'
    app.quit()
)

app.on('activate', () ->
  if !@mainWindow
    @mainWindow = createMainWindow()
)

app.on('ready', () ->
  @mainWindow = createMainWindow()
  @mainWindow.isResizable(true)
)

app.on 'resize', ->
  isMaximized = @mainWindow.isMaximized()
  isMinimized = @mainWindow.isMinimized()
  isFullScreen = @mainWindow.isFullScreen()
  state = wndState
  if isMinimized and state != WND_STATE.MINIMIZED
    wndState = WND_STATE.MINIMIZED
    sendWindowSizeChange 'minimize'
  else if isFullScreen and state != WND_STATE.FULL_SCREEN
    wndState = WND_STATE.FULL_SCREEN
    sendWindowSizeChange 'fullscreen'
  else if isMaximized and state != WND_STATE.MAXIMIZED
    wndState = WND_STATE.MAXIMIZED
    sendWindowSizeChange 'maximize'
  else if state != WND_STATE.NORMAL
    wndState = WND_STATE.NORMAL
    sendWindowSizeChange 'normal'
