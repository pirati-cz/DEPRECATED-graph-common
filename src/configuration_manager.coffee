class ConfigurationManager

  constructor: (configuration) ->
    @configuration = configuration

  get_configuration: () ->
  	return @configuration

module.exports = ConfigurationManager