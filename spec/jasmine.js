var Jasmine = require('jasmine')
var SpecReporter = require('jasmine-spec-reporter').SpecReporter
var jasmineEnv = new Jasmine()

jasmineEnv.env.clearReporters() // replace default dots reporter with jasmine-spec-reporter
jasmineEnv.addReporter(new SpecReporter())
jasmineEnv.loadConfigFile() // load jasmine.json configuration

jasmineEnv.DEFAULT_TIMEOUT_INTERVAL = 10000
jasmineEnv.execute()
