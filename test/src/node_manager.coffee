'use strict'

should = require('should')
NodeManager = require('../../lib/node_manager')
Query = require('../../lib/query')

describe('NodeManager', () ->

  describe('query', () ->

    it('should update node information in query', (done) ->
      node_mapping = {
        "status" : { name: "status", router: 'DummyRouter' }
      }
      node_manager = new NodeManager(node_mapping)
      node_manager.should.be.instanceof(NodeManager)
      query = new Query('status', 'read')
      node_manager.query(query)
      should(query.node).be
      query.node.name.should.equal(node_mapping["status"].name)
      query.node.router.should.equal(node_mapping["status"].router)
      done()
    )

  )
)
