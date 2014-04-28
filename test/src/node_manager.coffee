'use strict';

should = require('should')
NodeManager = require('../lib/node_manager')
Query = require('../lib/query')

describe('NodeManager', () ->

  describe('get_node_for_query', () ->

    it('should return node by query', (done) ->
      node_mapping = { 
        "status" : { name: "status", router: 'DummyRouter' }
      }
      node_manager = new NodeManager(node_mapping)
      node_manager.should.be.instanceof(NodeManager)
      query = new Query('status', 'read')
      node_manager.get_node_for_query(query).should.equal(node_mapping["status"])
      done()
    )

  )
)
