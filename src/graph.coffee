GQL = require('./gql')
NodeManager = require('./node_manager')

class Graph

  constructor: (configuration_manager) ->
    @configuration_manager = configuration_manager
    @configuration = @configuration_manager.get_configuration()
    @node_manager = new NodeManager(@configuration.node_manager, @configuration.route_manager)

  run: (gql, callback) ->
    self = @
    GQL.parse(gql, (query) ->
      self.query(query, callback)
    )

  query: (query, callback) ->
    @node_manager.get_router(query, (router) ->
      router.route(query, callback) if router
    )

module.exports = Graph