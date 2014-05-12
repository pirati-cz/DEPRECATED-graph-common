Graph API Query

    class Query

      constructor: (node, action, data) ->
        @node = node
        if (typeof @node == 'object' and node.node and node.action and
            typeof node.node == 'string' and typeof node.action == 'string')
          data = @node.data
          action = @node.action
          @node = @node.node

        @action = action
        unless @action in ['create', 'read', 'update', 'delete']
          @action = 'read'

        @data = data

      run: (callback) ->
        if @router
          @router.route(@, callback)

    module.exports = Query
