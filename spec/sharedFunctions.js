const request = require('request')

exports.createEvent = async (endpoint, data, user, done) => {
  var body = JSON.stringify(data)
  // console.log(body)
  request(
    {
      method: 'POST',
      uri: endpoint,
      auth: user.auth,
      headers: {
        'content-type': 'application/json'
      },
      body: body
    },
    function (error, response) {
      if (error) {
        console.log(error)
      }
      expect(response.statusCode).toEqual(201)
      done()
    }
  )
}
