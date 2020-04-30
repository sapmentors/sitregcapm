const axios = require('axios')

exports.createEvent = async (endpoint, data, user, done) => {
  const body = JSON.stringify(data)
  axios.post(endpoint, body, {
    auth: { username: user.auth.user },
    headers: {
      'content-type': 'application/json'
    }
  })
    .then(response => {
      expect(response.status).toEqual(201)
      done()
    }).catch(error => {
      console.log(error)
    })
}
