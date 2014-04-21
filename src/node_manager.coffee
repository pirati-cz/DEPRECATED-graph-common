class NodeManager

  constructor: (node_manager_mapping, route_manager_mapping) ->
    @node_manager_mapping = node_manager_mapping
    @route_manager_mapping = route_manager_mapping

  get_router: (query, callback) ->
    node_info = @node_manager_mapping[query.node]
    if !node_info
      callback(null)
      return null
    router_name = node_info.router
    router_info = @route_manager_mapping[router_name]
    router_info.loaded = require(@route_manager_mapping[router_name].require) unless router_info.loaded
    @route_manager_mapping[router_name] = router_info
    router = router_info.loaded()
    callback(router)
    return router

module.exports = NodeManager