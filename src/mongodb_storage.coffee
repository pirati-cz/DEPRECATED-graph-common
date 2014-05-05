class MongoDBStorage

  constructor: (database_uri) ->
    @mongoose = require('mongoose')
    @Schema = @mongoose.Schema
    @db = @mongoose.connect(database_uri)
    @connection = @db.connection

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