module.exports = (app) ->

    Usuario = app.models.usuario

    index: (req, res) ->
        res.render "index", title: "CoffeeXpress"

    login: (req, res) ->
        nome = req.param 'nome'
        email = req.param 'email'

        return res.redirect '/' unless nome and email

        Usuario.findOne email: email
            .select 'nome email'
            .exec().then (usuario) ->

                redirecionaContatos = (usuario) ->
                    req.session.usuario = usuario
                    res.redirect '/contatos'

                return redirecionaContatos usuario if usuario

                Usuario.create
                    nome: nome
                    email: email
                .then redirecionaContatos

    logout: (req, res) ->
        req.session.destroy()
        res.redirect '/'
