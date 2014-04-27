class RedirectRouter

  @route: (query, callback, options) ->
    query.node = options.redirect
    query.graph.query(query, callback)

module.exports = RedirectRouter