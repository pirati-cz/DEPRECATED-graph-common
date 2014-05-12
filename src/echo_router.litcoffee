    class EchoRouter

      @route: (query, callback) ->
        query.result = query.data
        callback(query)

    module.exports = EchoRouter
