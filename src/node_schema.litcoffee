Model schema for Node objects

    class NodeSchema

      @schema = { name: 'Node', definition: {
        name: { type: String, required: true, unique: true },
        path: { type: String, required: true, unique: true },
        routers: {}
      }}

      @methods = {
        parse_path: () ->
          #...
      }

    module.exports = NodeSchema
