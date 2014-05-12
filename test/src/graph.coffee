'use strict'

should = require('should')
ConfigurationManager = require('../../lib/configuration_manager')
Graph = require('../../lib/graph')
Query = require('../../lib/query')

describe('Graph', () ->

  describe('create and run query', () ->

    it('should create graph and run gql script', (done) ->

      cm = new ConfigurationManager({
        name: "Open Graph API",
        di: {
          StorageManager: './storage_manager',
          NodeManager: './node_manager',
          RouteManager: './route_manager',
          GQL: './gql'
        },
        StorageManager: "mongodb://localhost/graph",
        NodeManager: {
          "node/one" : { name: "node/one", router: 'EchoRouter' }
        },
        RouteManager: {
          "EchoRouter" : { name: "EchoRouter", require: "./echo_router" }
        },
      })
      graph = new Graph(cm)
      graph.should.be.instanceof(Graph)
      should(graph.route_manager).be
      should(graph.node_manager).be
      should(graph.storage_manager).be
      data = '{ "test": "value" }'
      query = new Query('node/one', 'create', data)
      graph.query(query, (query) ->
        data.should.equal(query.data)
        done()
      )

    )
  )
)
