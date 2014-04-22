module.exports = (app) ->

    (req, res, next) ->
        return res.redirect '/' unless req.session.usuario
        next()
