EchoRouter is Graph API Router returning data back unchanged

    class EchoRouter

      @route: (query, callback) ->
        query.result = query.data
        callback(query)

    module.exports = EchoRouter
