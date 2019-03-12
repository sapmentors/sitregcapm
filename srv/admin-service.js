


module.exports = (srv) => {

    const {Event} = cds.entities ('com.sap.sapmentors.sitregcapm')
  

    srv.before ('CREATE', 'Events', async (req) => {
     

    })
  

    srv.after ('READ', 'Events', each => {
  
    })
  
  }
