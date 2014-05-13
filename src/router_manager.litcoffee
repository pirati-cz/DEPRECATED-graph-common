RouterManager takes care of building query's path through its routers.

    Router = null

    class RouterManager

      constructor: (graph, done) ->
        @graph = graph
        @database = @graph.database
        Router = @database.model('Router')
        @routers = {}
        @load_routers(done)

      load_routers: (done) ->
        self = @
        Router.find({}, (err, routers) ->
          self.add_router router for router in routers
          done())

      add_router: (router) ->
        @graph.verbose('RouterManager> add:', router.name)
        @routers[router.name] = router

      get_router: (router_name) ->
        unless @routers[router_name].loaded
          @routers[router_name].loaded = require(@routers[router_name].require)
        return @routers[router_name].loaded

      create_router: (router_data) ->
        @graph.verbose('RouterManager> create:', router_data)
        router = new Router router_data
        @add_router router

      query: (query) ->
        @graph.verbose('RouterManager> resolved:', query.node.router)
        query.router = @get_router(query.node.router)

    module.exports = RouterManager
