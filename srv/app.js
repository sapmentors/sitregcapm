const app = require('express')()
const helmet = require('helmet')
const compression = require('compression')
const cds = require('@sap/cds')

app.use(helmet())
app.use(compression({ threshold: '512b' }))
/*
if (process.env.NODE_ENV === 'production') {

}
*/

app.loaded = []

app.loaded.push(
  cds
    .serve('OrganizerService', {
      passport: {
        strategy: 'mock',
        users: {
          organizer: {
            jwt: {
              userInfo: { logonName: 'organizer@example.com' },
              scopes: ['organizer']
            }
          }
        }
      }
    })
    .in(app)
    .at('organizer/')
)

app.loaded.push(
  cds
    .serve('AdminService', {
      passport: {
        strategy: 'mock',
        users: {
          administrator: {
            jwt: {
              userInfo: { logonName: 'admin@example.com' },
              scopes: ['admin']
            }
          }
        }
      }
    })
    .in(app)
    .at('admin/')
)

app.loaded.push(
  cds
    .serve('PublicService', {})
    .in(app)
    .at('public/')
    .catch(console.error)
)

module.exports = app
