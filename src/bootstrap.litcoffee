Bootstrap Graph API

    class Bootstrap

      @bootstrap: (graph) ->

        graph.create_router { name: "EchoRouter", require: "./echo_router" }
        graph.create_router { name: "RedirectRouter", require: "./redirect_router" }
        graph.create_router { name: "StaticRouter", require: "./static_router" }
        graph.create_router { name: "StorageRouter", require: "./storage_router" }
        graph.create_router { name: "ChainRouter", require: "./chain_router" }


        graph.create_node {
          name: "root",
          path: "",
          routers: {
            StaticRouter: "Piráti Open Graph API"
          }
        }

        graph.create_node { name: "echo", path: "echo", routers: { EchoRouter: true } }

        graph.create_node {
          name: "redirect",
          path: "echo/redirect",
          routers: {
            RedirectRouter: "echo"
          }
        }

        graph.create_node { name: "schema", path: "schema", routers: { StorageRouter: "Schema" } }
        graph.create_node { name: "router", path: "router", routers: { StorageRouter: "Router" } }
        graph.create_node { name: "node",   path: "node",   routers: { StorageRouter: "Node" } }

        graph.create_node {
          name: "chain",
          path: "chain",
          routers: {
            StaticRouter: "Chained echo",
            RedirectRouter: "echo/redirect"
          }
        }

    module.exports = Bootstrap
