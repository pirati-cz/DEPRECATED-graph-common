SchemaManager takes care of schemas and models and their loading

    self = null

    class SchemaManager

      constructor: (graph, core_model_mapping) ->
        self = @
        @graph = graph
        @database = @graph.database
        @schemas = []
        @models = []
        @core_model_mapping = core_model_mapping
        @init_core_model(() ->
          self.reload())

      load_core_model: (name, file) ->
        model_definition = require(file)
        schema = model_definition.schema
        methods = model_definition.methods
        @load_schema(schema, (schema_object) ->
          Object.keys(model_definition.methods).forEach((method) ->
            schema_object.methods[method] = model_definition.methods[method]))
        @model(name)

      init_core_model: (done) ->
        for core_model, file of @core_model_mapping
          @load_core_model(core_model, file)
        done()

      reload: () ->
        Schema = @model('Schema')
        Schema.find({}, (err, schemas) ->
          schemas.forEach((schema) ->
            self.load_schema(schema)))

      load_schema: (schema, callback) ->
        @graph.verbose('SchemaManager> add:', schema.name)
        Schema = @database.Schema
        @schemas[schema.name] = new Schema(schema.definition)
        @database.apply_plugins(@schemas[schema.name])
        callback(@schemas[schema.name]) if callback

      model: (schema_name) ->
        return @models[schema_name] if @models[schema_name]
        return null unless @schemas[schema_name]
        @models[schema_name] = @database.model(schema_name, @schemas[schema_name])

    module.exports = SchemaManager
