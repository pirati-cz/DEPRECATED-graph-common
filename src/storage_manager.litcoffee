    Query = require('./query')

    class StorageManager

      constructor: (configuration_uri) ->
        @configuration = uri: configuration_uri
        @parse_configuration_uri(configuration_uri)
        @load_driver()
        @instantiate_database()

      parse_configuration_uri: (configuration_uri) ->
        [driver, rest] = configuration_uri.split('://')
        [host, database] = rest.split('/')
        @configuration.driver = driver
        @configuration.host = host
        @configuration.database = database

      load_driver: () ->
        @driver = require('./'+@configuration.driver+'_storage')

      instantiate_database: () ->
        @db = @database = new @driver(@configuration.uri)

      __noSuchMethod__: (method, args...) ->
        if @driver
          @instantiate_database() unless @database
          @database.method.apply(null, args...)

    module.exports = StorageManager
