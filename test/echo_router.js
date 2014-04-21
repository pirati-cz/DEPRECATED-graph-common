'use strict';

var should = require('should');
var EchoRouter = require('../lib/echo_router');
var Query = require('../lib/query');

describe('EchoRouter', function() {

  describe('route', function(){

    it('should return routed query', function(done) {
      var query = new Query('testnode', 'create', '{ "test": "value" }');
      EchoRouter.route(query, function(returned_query) {
        returned_query.should.equal(query);
        done();
      });
    });

  });
});
