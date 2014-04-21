class Node

  constructor: (node) ->
  	@node = node
  	@node = Node.parse(node) if typeof node == 'string'

  @parse: (node_string) ->
  	

module.exports = Query