module.exports = (app) ->

    Usuario = app.models.usuario

    listar: (req, res) ->
        Usuario.findById req.session.usuario._id, (err, usuario) ->
            res.render "contatos/lista",
                contatos: usuario.contatos

    prepararNovo: (req, res) ->
        res.render "contatos/novo"

    prepararEdicao: (req, res) ->
        Usuario.findById req.session.usuario._id, (err, usuario) ->
            res.render "contatos/edicao",
                contato: usuario.contatos.id req.param 'id'

    inserir: (req, res, next) ->
        contatos = req.session.usuario.contatos
        Usuario.findById req.session.usuario._id, (err, usuario) ->
            usuario.contatos.push req.param 'contato'
            usuario.save (err) ->
                return next err if err
                res.redirect '/contatos'

    editar: (req, res, next) ->
        Usuario.findById req.session.usuario._id, (err, usuario) ->
            contato = usuario.contatos.id req.param 'id'
            edicao = req.param 'contato'
            contato.nome = edicao.nome
            contato.email = edicao.email
            usuario.save (err) ->
                return next err if err
                res.redirect '/contatos'

    excluir: (req, res, next) ->
        Usuario.findById req.session.usuario._id, (err, usuario) ->
            usuario.contatos.id req.param 'id'
                .remove()
            usuario.save (err) ->
                return next err if err
                res.redirect '/contatos'
