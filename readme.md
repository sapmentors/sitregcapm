# SAP Event Registration app backend

This is the successor of [SITreg](https://github.com/sapmentors/SITreg/). Now implemented using the [SAP Cloud Application Programming Model](https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/00823f91779d4d42aa29a498e0535cdf.html). Check out the [roadmap](https://github.com/sapmentors/sitregcapm/issues/1) for the next steps.

## Get Started

### Development Environment

We recommend using Visual Studio Code as local development environment. To get the language support for the CDS objects you must manually install the corresponding extension for Visual Studio Code.
To install this extension, proceed as follows

1. Download the vsix file from [SAP Development Tools -> Cloud -> CDS Language Support for Visual Studio Code](https://tools.hana.ondemand.com/#cloud)
2. Install the downloaded vsix file in Visual Studio Code using command Install from VSIX...

### NPM Registry

The NPM packages for CDS are not part of the default NPM registry. As a consequence, you must configure your registry to lookup the packages in the SAP NPM registry. Enter the following command:

```sh
npm set @sap:registry=https://npm.sap.com
```

### CDS Command Line Tools

Install the CDS command line tools

```sh
npm i -g @sap/cds
```

### Build the Project

To build the project, walk through the following steps

1. Download or clone the repository.
2. Navigate to the folder of your local repository
3. Execute the command `npm install`to install the relevant NPM packages
4. Execute the command `npm run build` to trigger a clean build of the project
5. Execute the command `npm run deploy` to deploy in the local sqlite database
6. Execute the command `npm start` to startup the project locally

You can now access the services via

```sh
 http://localhost:4004
```

### Initialize the Local Database

Run the following command to Initialize your local SQLite DB:

```sh
cds deploy --to sqlite:db/sitregcapm.db
```

Do not forget to repeat this step to initialize the local database whenever you changed the datamodel

### Setup XSUAA

To be able to use authenticaiton and the defined scopes (authorization) a XSUAA must be set up.
First compile the CDS to xs-security.json:

```sh
mkdir gen
cds srv/ --to xsuaa,json > gen/xs-security.json
```

now deploy that to your SAP CP Cloud Foundry trial:

```sh
cf login
cf create-service xsuaa application sitregcapm-uaa -c gen/xs-security.json
```

then create the service-key:

```sh
cf create-service-key sitregcapm-uaa sitregcapm-uaa-key && cf service-key sitregcapm-uaa sitregcapm-uaa-key
```

```sh
cf push sitregcapm --no-start --no-manifest --random-route
cf bind-service sitregcapm sitregcapm-uaa
cf restage sitregcapm
```

### Recommended Extensions

Local execution makes use of [SQLite3](https://www.sqlite.org/index.html) as database. To get an insight into the database from visual studio code we recommend to install the [SQLite Extension](https://marketplace.visualstudio.com/items?itemName=alexcvzz.vscode-sqlite) from the Visual Studio Marketplace

## Communication

Please [join](https://sapmentors-slack-invite.cfapps.eu10.hana.ondemand.com/) the [SAP Mentors & Fiends Slack Workgroup in the channel #sitreg](https://sapmentors.slack.com/messages/C20RKRU2H/).

## Additional Resources

Here are some additional resources for the SAP Cloud Application Programming Model (CAPM):

- [help.sap.com](https://help.sap.com/viewer/65de2977205c403bbc107264b8eccf4b/Cloud/en-US/00823f91779d4d42aa29a498e0535cdf.html)
- [developers.sap.com tutorial](https://developers.sap.com/tutorials/cp-apm-nodejs-create-service.html)
- [Hands-on SAP dev with qmacro – live stream series](https://blogs.sap.com/2019/01/16/hands-on-sap-dev-with-qmacro-new-live-stream-series/)