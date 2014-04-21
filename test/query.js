'use strict';

var should = require('should');
var Query = require('../lib/query');

describe('Query', function() {

  describe('new', function(){

    it('new(arguments)', function(done) {
      var query = new Query('testnode', 'create', '{ "test": "value" }');
      query.should.be.instanceof(Query);
      query.should.have.property('node', 'testnode');
      query.should.have.property('action', 'create');
      query.should.have.property('data', '{ "test": "value" }');
      done();
    });

    it('new(object)', function(done) {
      var query = new Query({
        "node": 'testnode2',
        "action": 'update',
        "data": '{ "test2": "value2" }'
      });
      query.should.be.instanceof(Query);
      query.should.have.property('node', 'testnode2');
      query.should.have.property('action', 'update');
      query.should.have.property('data', '{ "test2": "value2" }');
      done();
    });

  });
});
