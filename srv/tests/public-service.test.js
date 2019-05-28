'use strict'

// use test spec file name as description to allow navigation from the test results view
describe(__filename, () => {
  const request = require('supertest')
  this.test = require('../utils/tests')
  this.app = this.test.getExpress()

  beforeAll(done => {
    Promise.all(this.app.loaded).then(() => done())
  })

  describe('OData V4 Service for anonymous', () => {
    it('returns a JSON payload', done => {
      request(this.app)
        .get('/public')
        .expect(200)
        .expect('Content-Type', 'application/json;odata.metadata=minimal')
        .end(error => (error ? done.fail(error) : done()))
    })
    it('returns a list of RelationsToSAP', done => {
      request(this.app)
        .get('/public/RelationsToSAP')
        .expect(200)
        .expect('Content-Type', 'application/json;odata.metadata=minimal')
        .end(function (err, res) {
          if (err) return done(err)
          expect(res.body.value.length).toBeGreaterThan(1)
          done()
        })
    })
    it('Check if RelationsToSAP is returned in German', done => {
      request(this.app)
        .get('/public/RelationsToSAP?sap-language=de')
        .auth('administrator', '')
        .expect(200)
        .expect('Content-Type', 'application/json;odata.metadata=minimal')
        .end(function (err, res) {
          if (err) return done(err)
          expect(res.body.value[0].name).toBe('Sonstige')
          done()
        })
    })
  })
})
