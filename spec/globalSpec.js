const request = require('request')
const config = require('./config')
const server = require('../v2server')

beforeAll(async function (done) {
  // Check if the server is already running
  request.get(config.endpoint, async function (error, response) {
    if (error) {
      await server.run(done)
    } else {
      done()
    }
  })
})
