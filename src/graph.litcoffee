Graph is the core module. It loads all submodules when instantiate depending on the configuration.

    GQL = null
    SchemaManager = null
    StorageManager = null
    RouterManager = null
    NodeManager = null
    Bootstrap = null
    Logger = null

    class Graph

      constructor: (configuration_manager, done) ->
        @configure(configuration_manager)
        @inject()
        @instantiate(done)

      configure: (configuration_manager) ->
        @configuration_manager = configuration_manager
        @configuration = @configuration_manager.get_configuration()

      inject: () ->
        di = @configuration.di or {}
        GQL = require(di.GQL or './gql')
        Bootstrap = require(di.Bootstrap or './bootstrap')
        StorageManager = require(di.StorageManager or './storage_manager')
        RouterManager = require(di.RouterManager or './router_manager')
        NodeManager = require(di.NodeManager or './node_manager')
        SchemaManager = require(di.SchemaManager or './schema_manager')
        Logger = require(di.Logger or 'winston')

      instantiate: (done) ->
        self = @
        @logger = Logger
        @logger.cli()
        @logger.level = @configuration.logLevel || 'info'
        if @configuration.logFile
          @logger.add(@logger.transports.File, {
            level: @logger.level,
            colorize: true,
            json: false,
            filename: @configuration.logFile
          })
        @info('Logging level set:', @logger.level)
        @storage_manager = new StorageManager(self, @configuration.StorageManager)
        @database = @storage_manager.database
        @schema_manager = new SchemaManager(self, @configuration.SchemaManager or {
          "Schema": "./schema_schema",
          "Node": "./node_schema",
          "Router": "./router_schema"
        })
        @node_manager = new NodeManager(self, () ->
          self.router_manager = new RouterManager(self, () ->
            Bootstrap.bootstrap(self) if Bootstrap
            self.info('Graph API initiated')
            done()
          )
        )

      run: (gql, callback) ->
        @input('GQL>', gql)
        self = @
        GQL.parse(gql, (query) ->
          self.query(query, callback)
        )

      query: (query, callback) ->
        @debug('Graph> Query:', { node: query.node?.path or query.node, action: query.action, data: query.data} )
        query.graph = @
        @node_manager.query(query)
        @router_manager.query(query)
        query.run(callback)

      disconnect: () ->
        @database.disconnect()
        @info('Disconnected')

      create_node: (node_data) ->
        @node_manager.create_node node_data

      create_router: (router_data) ->
        @router_manager.create_router router_data

      log: (args...) -> Logger.log args...

      error: (args...) -> Logger.error args...

      warn: (args...) -> Logger.warn args...

      help: (args...) -> Logger.log 'help', args...

      data: (args...) -> Logger.log 'data', args...

      info: (args...) -> Logger.info args...

      debug: (args...) -> Logger.log 'debug', args...

      prompt: (args...) -> Logger.log 'prompt', args...

      verbose: (args...) -> Logger.log 'verbose', args...

      input: (args...) -> Logger.log 'input', args...

      silly: (args...) -> Logger.log 'silly', args...

    module.exports = Graph
