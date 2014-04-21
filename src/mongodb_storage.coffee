class MongoDBStorage

  constructor: () ->

  create: (collection, object) ->
    queries = []
    lines = script.split("\n")
    lines.forEach((line) ->
      queries.push(GQL.parse_line(line, callback))
    )
    return queries

  read: (collection, options) ->
  update: (collection, object, options) ->
  delete: (collection, options) ->

module.exports = GQL