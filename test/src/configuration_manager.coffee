'use strict'

should = require('should')
ConfigurationManager = require('../../lib/configuration_manager')

conf = {
  "database": "mongo",
  "name": "pirati"
}

describe('ConfigurationManager', () ->

  describe('new', () ->

    it('new', (done) ->
      cm = new ConfigurationManager(conf)
      cm.should.be.instanceof(ConfigurationManager)
      cm.should.have.property('configuration', conf)
      done()
    )

    it('get_configuration', (done) ->
      cm = new ConfigurationManager(conf)
      should(cm.get_configuration()).equal(conf)
      done()
    )

  )
)
