"use strict";
module.exports = {
    getExpress: (secure = false) => {
		const cds = require("@sap/cds")
        const express = require("express")
        const app = express()
        const csn = cds.load('srv/gen/csn.json')
        cds.serve('all').from(csn).in(app)
        return app
	}
};