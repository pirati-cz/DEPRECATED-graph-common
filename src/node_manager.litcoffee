NodeManager takes care of Graph API Nodes and updates Query's Node information

    Node = null

    class NodeManager

      constructor: (graph, done) ->
        @graph = graph
        @database = @graph.database
        Node = @database.model('Node')
        @nodes = {}
        @load_nodes(done)

      load_nodes: (done) ->
        self = @
        Node.find({}, (err, nodes) ->
          self.add_node node for node in nodes
          done())

      add_node: (node) ->
        @graph.verbose('NodeManager> add:',node.name)
        @nodes[node.path] = node

      create_node: (node_data) ->
        @graph.verbose('NodeManager> create:', node_data)
        node = new Node node_data
        @add_node node

      query: (query, callback) ->
        if typeof query.node == 'string'
          parsed = require('url').parse(query.node, true)
          node_path = parsed.pathname.replace(/^\//g, '').replace(/\/$/g, '')
          @graph.verbose('NodeManager> path:', node_path)

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
            query.graph.verbose('NodeManager> resolved:', node.path)
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
