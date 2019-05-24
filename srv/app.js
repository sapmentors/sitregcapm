const app = require('express')()
const helmet = require('helmet')
const compression = require('compression')
const cds = require('@sap/cds')

app.use(helmet())
app.use(compression({threshold: '512b'}))
/*
if (process.env.NODE_ENV === 'production') {

}
*/

app.loaded = []

app.loaded.push(cds.serve('./srv/admin-service', {
    "passport": {
        "strategy": "mock",
        "users": {
          "administrator": {
            "jwt": {
              "userInfo": { "logonName": "admin@example.com" },
              "scopes": ["admin"]
            }
          }
        }
      }
}).in(app).at('admin/'))
app.loaded.push(cds.serve('./srv/public-service', {}).in(app).at('public/').catch(console.error))

module.exports = app