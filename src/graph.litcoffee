Graph is the core module. It loads all submodules when instantiate depending on the configuration.

    GQL = null
    SchemaManager = null
    StorageManager = null
    RouterManager = null
    NodeManager = null

    Node = null
    Schema = null
    Router = null

    class Graph

      constructor: (configuration_manager, done) ->
        @configure(configuration_manager)
        @inject()
        @instantiate(done)

      configure: (configuration_manager) ->
        @configuration_manager = configuration_manager
        @configuration = @configuration_manager.get_configuration()

      inject: () ->
        di = @configuration.di
        GQL = require(di.GQL)
        StorageManager = require(di.StorageManager)
        RouterManager = require(di.RouterManager)
        NodeManager = require(di.NodeManager)
        SchemaManager = require(di.SchemaManager)

      instantiate: (done) ->
        self = @
        @storage_manager = new StorageManager(@configuration.StorageManager)
        @database = @storage_manager.database
        @schema_manager = new SchemaManager(@configuration.SchemaManager, @database)
        @node_manager = new NodeManager(@configuration.NodeManager, @database, () ->
          self.router_manager = new RouterManager(self.configuration.RouterManager, self.database)
          done())

      run: (gql, callback) ->
        self = @
        GQL.parse(gql, (query) ->
          self.query(query, callback)
        )

      query: (query, callback) ->
        query.graph = @
        @node_manager.query(query)
        @router_manager.query(query)
        query.run(callback)

      disconnect: () ->
        #console.log "disconnecting"
        @database.disconnect()

    module.exports = Graph
