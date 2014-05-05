module.exports = (app) ->

    Usuario = app.models.usuario

    index: (req, res) ->
        login = req.param('login')
        res.render "index",
            login: login || {}
            mensagem: if login then "nome e email são obrigatórios"

    login: (req, res, next) ->
        login = req.param 'login'

        return next() unless login and login.nome and login.email

        Usuario.findOne email: login.email
            .select 'nome email'
            .exec().then (usuario) ->

                redirecionaContatos = (usuario) ->
                    req.session.usuario = usuario
                    res.redirect '/contatos'

                return redirecionaContatos usuario if usuario

                Usuario.create
                    nome: login.nome
                    email: login.email
                .then redirecionaContatos

    logout: (req, res) ->
        req.session.destroy()
        res.redirect '/'
