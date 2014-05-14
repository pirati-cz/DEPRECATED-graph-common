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
        @route(callback)

      route: (callback) ->
        @graph.verbose('Query> routing:', @current_router)
        if @current_router
          self = @
          @current_router.router.route(@, () ->
            self.past_routers = [] unless self.past_routers
            self.past_routers.push self.current_router
            self.current_router = self.routers.shift()
            if self.current_router
              self.route(callback)
            else
              callback(self)
          )

    module.exports = Query
