module.exports = (app) ->

    auth = app.middleware.autenticador
    chat = app.controllers.chat

    app.get "/chat", auth, chat.index
