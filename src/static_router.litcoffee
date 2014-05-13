StaticRouter is Graph API Router returning always the data specified in node's configuration

    class StaticRouter

      @route: (query, callback) ->
        query.data = query.node.configuration.data
        callback(query)

    module.exports = StaticRouter
