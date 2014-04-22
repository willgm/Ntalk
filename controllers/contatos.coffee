module.exports = ->

    listar: (req, res) ->
        res.render "contatos/lista",
            contatos: req.session.usuario.contatos

    visualizar: (req, res) ->
        contato = req.session.usuario.contatos[req.param 'id']
        if contato
            res.render "contatos/edicao", contato: contato
        else
            res.render "contatos/novo"

    inserir: (req, res) ->
        contatos = req.session.usuario.contatos
        novo = req.param 'contato'
        novo.id = contatos.length
        contatos.push novo
        res.redirect '/contatos'

    editar: (req, res) ->
        original = req.session.usuario.contatos[req.param 'id']
        edicao = req.param 'contato'
        original.nome = edicao.nome
        original.email = edicao.email
        res.redirect '/contatos'

    excluir: (req, res) ->
        req.session.usuario.contatos.splice req.param 'id', 1
        res.redirect '/contatos'
