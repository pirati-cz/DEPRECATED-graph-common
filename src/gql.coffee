Query = require('./query')

class GQL

  constructor: () ->

  @parse: (script, callback) ->
    queries = []
    lines = script.split("\n")
    lines.forEach((line) ->
      queries.push(GQL.parse_line(line, callback))
    )
    return queries

  @parse_line: (line, callback) ->
    quer = null
    m = line.match(/^\s*([\w_\-\/]+)\s+([\w_\-]+)\s?(.*)?$/)
    query = new Query(m[1], m[2], m[3]) if m
    callback(query) if callback
    return query

module.exports = GQL