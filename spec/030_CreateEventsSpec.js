const config = require('./config')
const shared = require('./sharedFunctions')
const endpoint = config.endpoint + 'organizer/Events'

describe('Create Events', function () {
  it('should create an event', function (done) {
    var data = {
      ID: 1,
      location: 'München',
      eventStart: '/Date(1475910000000)/',
      eventEnd: '/Date(1475942400000)/',
      description: 'SAP Inside Track',
      maxParticipants: 80
    }
    shared.createEvent(endpoint, data, config.user.organizer, done)
  })

  it('should read the created events, change the MaxParticipants and check the change', function (done) {
    done()
  })

  it('should add COORGANIZER to event', function (done) {
    done()
  })

  it("should read list of COORGANIZER's of an event", function (done) {
    done()
  })
})
