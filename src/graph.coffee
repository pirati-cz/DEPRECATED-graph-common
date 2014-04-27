GQL = null
Storage = null
RouteManager = null
NodeManager = null

class Graph

  constructor: (configuration_manager) ->
    @configure(configuration_manager)
    @inject()
    @instantiate()

  configure: (configuration_manager) ->
    @configuration_manager = configuration_manager
    @configuration = @configuration_manager.get_configuration()

  inject: () ->
    di = @configuration.di
    GQL = require(di.GQL)
    Storage = require(di.Storage)
    RouteManager = require(di.RouteManager)
    NodeManager = require(di.NodeManager)

  instantiate: () ->
    @storage = new Storage(@configuration.Storage)
    @route_manager = new RouteManager(@configuration.RouteManager)
    @node_manager = new NodeManager(@configuration.NodeManager, @configuration.RouteManager)

  run: (gql, callback) ->
    self = @
    GQL.parse(gql, (query) ->
      self.query(query, callback)
    )

  query: (query, callback) ->
    query.graph = @
    node = @node_manager.get_node_for_query(query)
    Router = @route_manager.get_Router(node.router) if node
    Router.route(query, callback, node.options) if Router

module.exports = Graph