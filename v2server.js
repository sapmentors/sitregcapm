function run (callback) {
  // load modules
  const express = require('express')
  const cds = require('@sap/cds')
  const proxy = require('@sap/cds-odata-v2-adapter-proxy')

  // config
  const host = '0.0.0.0'
  const port = 4004
  // ; needed to get passed in standard check https://github.com/standard/standard/issues/865
  ;(async () => {
    // create new app
    const app = express()
    app.use('/', express.static('app/'))

    app.get('/', function (req, res) {
      res.redirect('/webapp/index.html')
    })

    // serve odata v4
    await cds
      .connect('db') // ensure database is connected!
      .serve('all')
      .in(app)

    // serve odata v2
    process.env.XS_APP_LOG_LEVEL = 'none' // suppress debug logs
    app.use(
      proxy({
        // app
        path: 'v2',
        // target
        port: port
      })
    )

    // start server
    const server = app.listen(port, host, () => {
      console.info(`app is listing at ${port}`)
      const used = process.memoryUsage().heapUsed / 1024 / 1024
      console.log(
        `The script uses approximately ${Math.round(used * 100) / 100} MB`
      )
      if (callback) {
        callback()
      }
    })
    server.on('error', error => console.error(error.stack))
  })()
}

if (require.main === module) {
  run()
}

exports.run = run
