class EchoRouter

  @route: (query, callback) ->
    callback(query)

module.exports = EchoRouter