RedirectRouter is Graph API Router redirecting query to a node specified in node.configuration.redirect

    class RedirectRouter

      @route: (query, callback) ->
        query.graph.node_manager.find_node(query.current_router.configuration, (node) ->
          query.node = node
          query.graph.query(query, callback)
          )

    module.exports = RedirectRouter
