using com.sap.sapmentors.sitregcapm as sitreg from '../db/data-model';

service ReceptionistService {
    entity EventTypes @readonly as projection on sitreg.EventTypes;
    entity RelationsToSAP @readonly as projection on sitreg.RelationsToSAP;
    entity Events @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            UpdateRestrinctions: {Updatable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Events;

    entity Organizers @( 
            Capabilities: {
            UpdateRestrinctions: {Updatable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Organizers;

    entity Participants @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            UpdateRestrinctions: {Updatable: false},    
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Participants;

    entity Tickets @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Tickets;
    
    entity CoOrganizers @readonly as projection on sitreg.CoOrganizers{
        *,
        events: redirected to Events
        
    };
    entity Devices @readonly as projection on sitreg.Devices{
        *,
        events: redirected to Events
    };
    entity PrintQueues @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.PrintQueues{
        *,
        events: redirected to Events
    };
}
