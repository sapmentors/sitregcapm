const app = require('express')()
const helmet = require('helmet')
const compression = require('compression')
const cds = require('@sap/cds')
// needed to support i18n with sqlite
cds.options = { kind: 'sqlite' }

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
app.loaded.push(
  cds
    .serve('ParticipantService', {
      passport: {
        strategy: 'mock',
        users: {
          participant: {
            jwt: {
              userInfo: { logonName: 'participant@example.com' },
              scopes: ['participant']
            }
          }
        }
      }
    })
    .in(app)
    .at('participant/')
    .catch(console.error)
)
app.loaded.push(
  cds
    .serve('ReceptionistService', {
      passport: {
        strategy: 'mock',
        users: {
          receptionist: {
            jwt: {
              userInfo: { logonName: 'receptionist@example.com' },
              scopes: ['receptionist']
            }
          }
        }
      }
    })
    .in(app)
    .at('receptionist/')
    .catch(console.error)
)
module.exports = app
