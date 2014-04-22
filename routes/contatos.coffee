module.exports = (app) ->

    auth = app.middleware.autenticador
    contatos = app.controllers.contatos

    app.route "/contatos"
        .all auth
        .get contatos.listar
        .post contatos.inserir

    app.route "/contatos/:id"
        .all auth
        .get contatos.visualizar
        .put contatos.editar
        .delete contatos.excluir
