const app = require('./app')
const cds = require('@sap/cds')

cds.connect()

app.listen(process.env.PORT || 4004)
