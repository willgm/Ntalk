cluster = require "cluster"
os = require "os"

if cluster.isMaster
    os.cpus().forEach ->
        cluster.fork()

    cluster.on "listening", (worker) ->
        console.log "### Cluster #{worker.process.pid} conectado"

    cluster.on "disconnect", (worker) ->
        console.log "### Cluster #{worker.process.pid} esta desconectado"

    cluster.on "exit", (worker) ->
        console.log "### Cluster #{worker.process.pid} caiu fora"

else
    require "./app.coffee"