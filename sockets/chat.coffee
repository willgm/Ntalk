module.exports = (io) ->

    io.on "connection", (client) ->
        usuario = client.handshake.session.usuario
        client.on 'send-public-chat', (msg) ->
            client.broadcast.emit 'recive-public-chat',
                "<b>#{usuario.nome}:</b> #{msg}<br>"
