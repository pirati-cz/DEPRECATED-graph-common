'use strict';

should = require('should')
RouteManager = require('../lib/route_manager')

describe('RouteManager', () ->

  describe('get_Router', () ->

    it('should return router by name', (done) ->
      route_mapping = {
        "EchoRouter" : { name: "EchoRouter", require: "./echo_router" }
      }
      route_manager = new RouteManager(route_mapping)
      route_manager.should.be.instanceof(RouteManager)
      router = route_manager.get_Router('EchoRouter')
      should(router).be
      done()
    )

  )
)
