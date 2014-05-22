module.exports = (io) ->

    redis = require('../redisman').createClient()

    io.on "connection", (client) ->
        usuario = client.handshake.session.usuario

        msg = "<b>#{usuario.nome}:</b> entrou na sala"
        redis.rpush 'public-chat', msg
        client.broadcast.emit 'recive-public-chat', msg

        redis.lrange 'public-chat', 0, -1, (err, mensagens) ->
            for msg in mensagens
                client.emit 'recive-public-chat', msg

        client.on 'disconnect', ->
            msg = "<b>#{usuario.nome}:</b> saiu na sala"
            client.broadcast.emit 'recive-public-chat', msg
            redis.rpush 'public-chat', msg

        client.on 'send-public-chat', (msg) ->
            msg = "<b>#{usuario.nome}:</b> #{msg}"
            client.broadcast.emit 'recive-public-chat', msg
            redis.rpush 'public-chat', msg
