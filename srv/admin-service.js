


module.exports = (srv) => {

    const {Event} = cds.entities ('com.sap.sapmentors.sitregcapm')
  
    // Reduce stock of ordered books
    srv.before ('CREATE', 'Events', async (req) => {
      const Event = req.data

    })
  

    srv.after ('READ', 'Events', each => {
  
    })
  
  }
