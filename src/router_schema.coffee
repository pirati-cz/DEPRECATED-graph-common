class RouterSchema

  @schema = { name: 'Router', definition: {
      name: { type: String, required: true, unique: true },
      configuration: {}
      }}

  @methods = {

  }

module.exports = RouterSchema