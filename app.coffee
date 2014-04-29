express = require "express"
path = require "path"
favicon = require "static-favicon"
logger = require "morgan"
cookieParser = require "cookie-parser"
session = require "express-session"
load = require "express-load"
bodyParser = require "body-parser"
methodOverride = require "method-override"
http = require "http"
socketio = require "socket.io"

KEY = 'cdz'
SECRET = 'por atena!'

cookie = cookieParser SECRET
sessionStore = new session.MemoryStore()

app = express()
app.set "views", path.join __dirname, "views"
app.set "view engine", "jade"
app.use favicon()
app.use logger "dev"
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookie
app.use session secret: SECRET, key: KEY, store: sessionStore
app.use express.static path.join __dirname, "public"
app.use methodOverride()
server = http.createServer app

load 'middleware'
    .then 'controllers'
    .then 'routes'
    .into app

app.middleware.errors()

io = socketio.listen server

io.set 'authorization', (data, accept) ->
    cookie data, {}, (err) ->
        sessionID = data.signedCookies[KEY]
        sessionStore.get sessionID, (err, session) ->
            unless not err and session and session.usuario
                accept null, false
            else
                data.session = session
                accept null, true

io.on "connection", (client) ->
    usuario = client.handshake.session.usuario
    client.on 'send-public-chat', (msg) ->
        client.broadcast.emit 'recive-public-chat',
            "<b>#{usuario.nome}:</b> #{msg}<br>"

server.listen 3000, ->
    console.log "Running at localhost:#{server.address().port}"
