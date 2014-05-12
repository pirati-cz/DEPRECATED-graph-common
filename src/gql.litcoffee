GQL can read GQL text and parse it to Graph API queries

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
        query = null

        node = null
        GQL.parse_node(line, (parsed, rest) ->
          node = parsed
          line = rest
        )

        action = null
        GQL.parse_action(line, (parsed, rest) ->
          action = parsed
          line = rest
        )

        data = line.trim()

        query = new Query(node, action, data)
        callback(query) if callback
        return query

      @parse_node: (line, callback) ->
        line.replace(/^\s+/, '')
        splitted = line.split(' ')
        path = splitted.shift()
        rest = splitted.join(' ')
        callback(path, rest)
        return path

      @parse_action: (line, callback) ->
        line.replace(/^\s+/, '')
        splitted = line.split(' ')
        action = splitted.shift().toLowerCase()
        if action in ['create', 'read', 'update', 'delete']
          rest = splitted.join(' ')
        else
          action = 'read'
          rest = line
        callback(action, rest)
        return action

    module.exports = GQL
