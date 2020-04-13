const request = require('request')
const config = require('./config')
const endpoint = config.endpoint + 'admin/Events'

describe('Administrator should', function () {
  it('delete the event', function (done) {
    request(
      {
        method: 'DELETE',
        uri: endpoint + '(1)',
        auth: config.user.administrator.auth
      },
      function (error, response) {
        if (error) {
          console.log(error)
        }
        console.log(response.body)
        expect(response.statusCode).toEqual(204)
        done()
      }
    )
  })
})
