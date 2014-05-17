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
mongo = require 'mongoose'
morgan = require 'morgan'
RedisStore = require('connect-redis')(session)

KEY = 'cdz'
SECRET = 'por atena!'

cookie = cookieParser SECRET
sessionStore = new RedisStore

app = express()
app.use morgan()
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

app.db = mongo.connect 'mongodb://localhost/ntalk'

load 'middleware'
    .then 'models'
    .then 'controllers'
    .then 'routes'
    .into app

app.middleware.errors()

io = socketio.listen server

io.set 'log level', 1
io.set 'store', new socketio.RedisStore
io.set 'authorization', (data, accept) ->
    cookie data, {}, (err) ->
        sessionID = data.signedCookies[KEY]
        sessionStore.get sessionID, (err, session) ->
            unless not err and session and session.usuario
                accept null, false
            else
                data.session = session
                accept null, true

load 'sockets'
    .into io

server.listen 3000, ->
    console.log "Running at localhost:#{server.address().port}"
