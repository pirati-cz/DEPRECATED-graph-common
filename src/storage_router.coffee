class StorageRouter

  @route: (query, callback) ->
    db = query.graph.storage_manager.database
    options = query.node.configuration
    schema = options.schema
    query.data = JSON.parse(query.data) if typeof query.data is 'string'

    switch query.action
      when "create"
        db.create(schema, query.data, (data) ->
          query.data = data
          callback(query))
        return
      when "read"
        db.read(schema, {}, (data) ->
          query.data = data
          callback(query))
        return
      when "update"
        db.update(schema, query.data, {}, (data) ->
          query.data = data
          callback(query))
        return
      when "delete"
        db.delete(schema, {}, (data) ->
          query.data = data
          callback(query))
        return

    callback(null)

module.exports = StorageRouter