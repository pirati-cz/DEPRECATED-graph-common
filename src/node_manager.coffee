class NodeManager

  constructor: (node_mapping) ->
    @node_mapping = node_mapping

  get_node_for_query: (query) ->
    return @node_mapping[query.node]

module.exports = NodeManager