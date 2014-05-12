Model schema for Schema objects

    class SchemaSchema

      @schema = { name: 'Schema', definition: {
        name: { type: String, required: true, unique: true },
        definition: {}
      }}

      @methods = {

      }

    module.exports = SchemaSchema
