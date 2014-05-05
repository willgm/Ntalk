module.exports = (app) ->

    contato = app.db.Schema
        nome:
            type: String
            required:true
        email:
            type: String
            required:true

    usuario = app.db.Schema
        nome:
            type: String
            required:true
        email:
            type: String
            required:true
            index: unique:true
        contatos: [contato]

    app.db.model 'usuario', usuario