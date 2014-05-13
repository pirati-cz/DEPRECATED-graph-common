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
          router: 'StaticRouter',
          configuration: { data: "Piráti Open Graph API" }
        }

        graph.create_node { name: "echo", path: "echo", router: 'EchoRouter' }

        graph.create_node {
          name: "redirect",
          path: "echo/redirect",
          router: 'RedirectRouter',
          configuration: { redirect: "echo" }
        }

        graph.create_node { name: "schema", path: "schema", router: 'StorageRouter', configuration: { schema: "Schema" } }
        graph.create_node { name: "router", path: "router", router: 'StorageRouter', configuration: { schema: "Router" } }
        graph.create_node { name: "node",   path: "node",   router: 'StorageRouter', configuration: { schema: "Node" } }

    module.exports = Bootstrap
