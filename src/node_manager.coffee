class NodeManager

  constructor: (node_mapping, database, done) ->
    @database = database
    @Node = @database.model('Node')
    @node_mapping = node_mapping
    @nodes = {}
    for node_path of node_mapping
      @add_node(new @Node(node_mapping[node_path]))
    @load_nodes(done)

  load_nodes: (done) ->
    self = @
    @Node.find({}, (err, nodes) ->
      self.add_node node for node in nodes
      done())

  add_node: (node) ->
    @nodes[node.path] = node

  query: (query, callback) ->
    if typeof query.node == 'string'
      parsed = require('url').parse(query.node, true)

      node_path = parsed.pathname
      node_path.replace(/^\//g, '').replace(/\/$/g, '')

      query.search_query = parsed.query || {}
      conditions = query.search_query.conditions
      conditions = JSON.parse(conditions) if conditions and typeof conditions == 'string'
      query.search_query.conditions = conditions if conditions

      @find_node(node_path, (node) ->
        query.node = node
        query.unresolved_pathname = node_path
          .substr(node.path.length, node_path.length - node.path.length)
          .replace(/^\//g, '')
          .replace(/\/$/g, '')
        unless query.unresolved_pathname is '' or /\//.test(query.unresolved_pathname)
          query.search_query.conditions ?= {}
          query.search_query.conditions._id = query.unresolved_pathname
        query.node_path = node.path
        )

  find_node: (node_path, callback) ->
    unless node_path or node_path = ''
      node_path = ''

    node = @nodes[node_path]
    if node
      callback(node)
      return node

    if /\//.test(node_path)
      node_path = node_path.substr(0, node_path.lastIndexOf('/'))
    else
      node_path = ''
    return @find_node(node_path, callback)

module.exports = NodeManager