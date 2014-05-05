module.exports = (app) ->

    home = app.controllers.home

    app.get "/", home.index
    app.all "/login", home.login, home.index
    app.get "/logout", home.logout
