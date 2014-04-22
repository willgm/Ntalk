module.exports = (app) ->

    index: (req, res) ->
        res.render "index", title: "CoffeeXpress"

    login: (req, res) ->
        nome = req.param 'nome'
        email = req.param 'email'

        if nome and email
            req.session.usuario =
                nome: nome
                email: email
                contatos: []
            res.redirect '/contatos'
        else
            res.redirect '/'

    logout: (req, res) ->
        req.session.destroy()
        res.redirect '/'
