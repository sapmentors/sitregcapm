"use strict";
module.exports = {
    getExpress: (secure = false) => {
		const cds = require("@sap/cds")
        const express = require("express")
        
        const app = express()
        cds.serve('all')
            .from('srv/')
            .in(app)
            .catch((err) => {
				console.log(err);
				//			process.exit(1);
			})
        return app
	}
};