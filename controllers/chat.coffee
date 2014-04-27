module.exports = (app) ->

    index: (req, res) ->
        res.render "chat",
            usuario: req.session.usuario.nome
