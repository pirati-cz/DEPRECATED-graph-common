Model schema for Node objects

    class NodeSchema

      @schema = { name: 'Node', definition: {
        name: { type: String, required: true, unique: true },
        path: { type: String, required: true, unique: true },
        router: { type: String, required: true },
        configuration: {}
      }}

      @methods = {
        parse_path: () ->
          #...
      }

    module.exports = NodeSchema
