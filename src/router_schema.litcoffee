Model schema for Router objects

    class RouterSchema

      @schema = { name: 'Router', definition: {
        name: { type: String, required: true, unique: true },
        require: { type: String, required: true },
        configuration: {}
      }}

      @methods = {

      }

    module.exports = RouterSchema
