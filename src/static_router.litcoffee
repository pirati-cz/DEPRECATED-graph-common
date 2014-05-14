StaticRouter is Graph API Router returning always the data specified in node's configuration

    class StaticRouter

      @route: (query, callback) ->
        query.graph.debug('StaticRouter>', { data: query.current_router.configuration })
        query.data = query.current_router.configuration
        callback(query)

    module.exports = StaticRouter
