'use strict'

should = require('should')
RedirectRouter = require('../../lib/redirect_router')

describe('RedirectRouter', () ->

  describe('route', () ->

    it('should populate node property', (done) ->
      query = {
        node: { name: 'somenode', configuration: { redirect: 'redirectnode' } },
        graph: {
          node_manager: { find_node: (redirect, callback) -> callback({ name: 'redirectnode'}) },
          query: (query, callback) ->
            query.node.name.should.equal('redirectnode')
            done()
        }
      }
      RedirectRouter.route(query)
    )

  )
)
