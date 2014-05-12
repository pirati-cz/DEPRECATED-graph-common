'use strict'

should = require('should')
RouterManager = require('../../lib/router_manager')

describe('RouterManager', () ->

  describe('query', () ->

    it('should populate router property', (done) ->
      router_mapping = EchoRouter: { name: "EchoRouter", require: "./echo_router" }
      router_manager = new RouterManager(router_mapping)
      router_manager.should.be.instanceof(RouterManager)
      query = node: router: "EchoRouter"
      router_manager.query(query)
      should(query.router).be
      done()
    )

  )
)
