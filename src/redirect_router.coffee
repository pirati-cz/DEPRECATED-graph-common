class RedirectRouter

  @route: (query, callback) ->
    callback(query)

module.exports = RedirectRouter