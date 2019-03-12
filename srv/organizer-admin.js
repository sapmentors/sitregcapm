module.exports = (srv) => {

    //const {Event} = cds.entities ('com.sap.sapmentors.sitregcapm')
  
    
    srv.before ('CREATE', 'Events', async (req) => {
        console.log('After Update')
    })
  
    
    srv.before ('UPDATE', 'Events', each => {
      console.log('Before Update')
    })
  
  }