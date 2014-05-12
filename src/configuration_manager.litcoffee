ConfigurationManager is class for managing configuration of Graph API.
It must have get_configuration method returning configuration.
This implementation gets the configuration in constructor when instantiated.


    class ConfigurationManager

      constructor: (configuration) ->
        @configuration = configuration

      get_configuration: () ->
        return @configuration

    module.exports = ConfigurationManager
