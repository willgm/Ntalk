express = require "express"
path = require "path"
favicon = require "static-favicon"
logger = require "morgan"
cookieParser = require "cookie-parser"
session = require "express-session"
load = require "express-load"
bodyParser = require "body-parser"
methodOverride = require "method-override"

app = express()
app.set "views", path.join __dirname, "views"
app.set "view engine", "jade"
app.use favicon()
app.use logger "dev"
app.use bodyParser.json()
app.use bodyParser.urlencoded()
app.use cookieParser()
app.use session secret: 'por atena!'
app.use express.static path.join __dirname, "public"
app.use methodOverride()

load 'middleware'
    .then 'controllers'
    .then 'routes'
    .into app

app.middleware.errors()

server = app.listen 3000, ->
    console.log "Running at localhost:#{server.address().port}"
