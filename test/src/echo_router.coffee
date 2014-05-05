'use strict'

should = require('should')
EchoRouter = require('../../lib/echo_router')
Query = require('../../lib/query')

describe('EchoRouter', () ->

  describe('route', () ->

    it('should return routed query', (done) ->
      query = new Query('testnode', 'create', '{ "test": "value" }')
      EchoRouter.route(query, (returned_query) ->
        returned_query.should.equal(query)
        done()
      )
    )

  )
)
