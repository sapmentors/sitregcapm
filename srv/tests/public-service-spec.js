"use strict";
// use test spec file name as description to allow navigation from the test results view
describe(__filename, () => {
    const request = require("supertest");
    this.test = require("../utils/tests");
    this.app = this.test.getExpress();

    beforeAll((done) => {
        Promise.all(this.app.loaded)
            .then(() => done())
    })

    describe("OData V4 Service", () => {
        it("returns a JSON payload", (done) => {
          request(this.app)
            .get("/public")
            .expect(200)
            .expect("Content-Type", "application/json;odata.metadata=minimal")
            .end((error) => (error) ? done.fail(error) : done());
        });
    });     
});