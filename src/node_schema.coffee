class NodeSchema

  @schema = { name: 'Node', definition: {
      name: String
      path: String
      router: String
      configuration: {}
      }}

  @methods = {
  	parse_path: () ->
      #...
  }

module.exports = NodeSchema