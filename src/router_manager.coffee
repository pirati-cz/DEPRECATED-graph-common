class RouterManager

  constructor: (router_mapping) ->
    @router_mapping = router_mapping

  query: (query) ->
    router_name = query.node.router
    unless @router_mapping[router_name].loaded
      @router_mapping[router_name].loaded = require(@router_mapping[router_name].require)
    query.router = @router_mapping[router_name].loaded

module.exports = RouterManager