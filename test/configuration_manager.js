'use strict';

var should = require('should');
var ConfigurationManager = require('../lib/configuration_manager');

var conf = {
  "database": "mongo",
  "name": "pirati"
}

describe('ConfigurationManager', function() {

  describe('new', function() {

    it('new', function(done) {
      var cm = new ConfigurationManager(conf);
      cm.should.be.instanceof(ConfigurationManager);
      cm.should.have.property('configuration', conf);
      done();
    });

    it('get_configuration', function(done) {
      var cm = new ConfigurationManager(conf);
      should(cm.get_configuration()).equal(conf);
      done();
    });

  });
});
