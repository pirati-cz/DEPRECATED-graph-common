class Query

  constructor: (node, action, data) ->
  	@data = data
  	@action = action if action and typeof action == 'string'
  	@node = node if node and typeof node == 'string'
  	if (
  		typeof node == 'object' and
  	    (node.node and typeof node.node == 'string' and
  	    node.action and typeof node.action == 'string')
  	    )
  	  @data = node.data
  	  @action = node.action
  	  @node = node.node

module.exports = Query