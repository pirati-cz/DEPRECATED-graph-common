EchoRouter is Graph API Router returning data back unchanged

    class EchoRouter

      @route: (query, callback) ->
        callback(query)

    module.exports = EchoRouter
