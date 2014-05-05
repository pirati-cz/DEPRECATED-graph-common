class RedirectRouter

  @route: (query, callback) ->
    query.graph.node_manager.find_node(query.node.configuration.redirect, (node) ->
      query.node = node
      query.graph.query(query, callback)
      )

module.exports = RedirectRouter