MongoDBStorage is MongoDB Graph API Storage implementation using mongoose

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

      create: (query, callback) ->
        model = @model(query.schema)
        object = new model(query.data)
        object.save(callback)

      read: (query, callback) ->
        model = @model(query.schema)
        search_query = query.search_query || {}
        conditions = search_query.conditions || {}
        dbquery = model.find(conditions)

        properties = search_query.property?.join(' ') || undefined
        if properties
          dbquery = dbquery.select(properties)

        MongoDBStorage.add_uniq_search_option(dbquery, search_query, 'limit')
        MongoDBStorage.add_uniq_search_option(dbquery, search_query, 'skip')
        MongoDBStorage.add_multiple_search_option(dbquery, search_query, 'sort')
        MongoDBStorage.add_multiple_search_option(dbquery, search_query, 'populate')

        dbquery.exec((err, data) -> callback(data))

      update: (query, callback) ->
        model = @model(query.schema)

      delete: (query, callback) ->

      model: (args...) ->
        return @mongoose.model(args...)

      disconnect: () ->
        @connection.close()

      @add_uniq_search_option: (dbquery, search_query, option) ->
        value = search_query[option]
        if value and typeof value == 'array'
          value = value.pop()
        if value
          dbquery = dbquery[option](value)
        return dbquery

      @add_multiple_search_option: (dbquery, search_query, option) ->
        values = search_query[option]
        if values and typeof values == 'string'
          values = [values]

        if values
          dbquery = dbquery[option](value) for value in values
        return dbquery


    module.exports = MongoDBStorage
