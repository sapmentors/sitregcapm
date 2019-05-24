"use strict";
module.exports = {
    getExpress: (secure = false) => {
      const app = require('../app')
      const cds = require('@sap/cds')
      
      cds.connect()
      return app
	}
};