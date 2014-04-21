'use strict';

var should = require('should');
var GQL = require('../lib/gql');
var Query = require('../lib/query');

describe('GQL', function() {

  describe('parse_line', function(){

    it('should parse GQL line', function(done) {
      var line = 'application/forum/topic create { "message": "ahoj" }'
      GQL.parse_line(line, function (query) {
        query.should.be.instanceof(Query);
        query.should.have.property('node', 'application/forum/topic');
        query.should.have.property('action', 'create');
        query.should.have.property('data', '{ "message": "ahoj" }');
        done();
      })
    });

  });

  describe('parse', function(){


    it('should parse GQL sequence', function(done) {
      var gql_sequence = [
        'status read',
        'application/forum/topic create { "message": "nazdar" }',
        'node create { "name": "echo", "router", "echo" }'
      ];
      var n_queries = gql_sequence.length;
      var query_counter = 0;

      GQL.parse(gql_sequence.join('\n'), function (query) {
        query.should.be.instanceof(Query);
        should(query.node in {'status':'', 'application/forum/topic':'','node':''}).be.true;
        if (query.node == 'status') {
          query.should.have.property('action', 'read');
          should(query.data).be.undefined;
          query_counter++;
        }
        if (query.node == 'application/forum/topic') {
          query.should.have.property('action', 'create');
          query.should.have.property('data', '{ "message": "nazdar" }');
          query_counter++;
        }
        if (query.node == 'node') {
          query.should.have.property('action', 'create');
          query.should.have.property('data', '{ "name": "echo", "router", "echo" }');
          query_counter++;
        }
        if (query_counter == n_queries) {
          done();
        }
      })
    });
  });
});
