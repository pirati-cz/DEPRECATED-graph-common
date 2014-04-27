class RouteManager

  constructor: (route_mapping) ->
    @route_mapping = route_mapping

  get_Router: (router_name) ->
    unless @route_mapping[router_name].loaded
      @route_mapping[router_name].loaded = require(@route_mapping[router_name].require)
    return @route_mapping[router_name].loaded

module.exports = RouteManager