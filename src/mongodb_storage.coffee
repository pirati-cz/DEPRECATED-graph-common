class MongoDBStorage

  constructor: (database_uri) ->
    @mongoose = require('mongoose')
    @plugins = uniqueValidator: require('mongoose-unique-validator')
    @Schema = @mongoose.Schema
    @db = @mongoose.connect(database_uri)
    @connection = @db.connection

  apply_plugins: (schema) ->
    for plugin_name of @plugins
      schema.plugin(@plugins[plugin_name])

  create: (schema, properties_object, callback) ->
    model = @model(schema)
    object = new model(properties_object)
    object.save(callback)

  read: (schema, search_options, callback) ->
    model = @model(schema)
    model.find(search_options, (err, data) -> callback(data))

  model: (args...) ->
    return @mongoose.model(args...)

  update: (schema, properties_object, update_options, callback) ->
    model = @model(schema)

  delete: (schema, options, callback) ->

  disconnect: () ->
    @connection.close()

module.exports = MongoDBStorage