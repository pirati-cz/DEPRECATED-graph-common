class StorageRouter

  @route: (query, callback) ->
    db = query.graph.storage_manager.database
    query.schema = query.node.configuration.schema
    query.data = JSON.parse(query.data) if typeof query.data is 'string'

    if query.action in ['create', 'read', 'update', 'delete']
      db[query.action](query, (result) ->
        query.result = result
        callback(query))
    else
      callback(null)

module.exports = StorageRouter