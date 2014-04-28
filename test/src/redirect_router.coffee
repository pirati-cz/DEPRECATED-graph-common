'use strict';

should = require('should')
RedirectRouter = require('../lib/redirect_router')
Query = require('../lib/query')

describe('RedirectRouter', () ->

  describe('route', () ->

    it('should redirect to another node', (done) ->
      query = new Query('testnode', 'create', '{ "test": "value" }')
      options = { redirect: 'redirectnode' }
      query.graph = { # inject graph mock
        query: (query, callback) ->
          query.node.should.equal(options.redirect)
          done()
      }
      RedirectRouter.route(query, null, options)
    )

  )
)
