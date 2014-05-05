module.exports = (app) ->

    auth = app.middleware.autenticador
    contatos = app.controllers.contatos

    app.route "/contatos"
        .all auth
        .get contatos.listar
        .post contatos.inserir

    app.get "/contatos/novo",
        auth, contatos.prepararNovo

    app.route "/contatos/:id"
        .all auth
        .get contatos.prepararEdicao
        .put contatos.editar
        .delete contatos.excluir
