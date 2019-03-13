using com.sap.sapmentors.sitregcapm as sitreg from '../db/data-model';

service ReceptionistService {
    entity EventTypes @readonly as projection on sitreg.EventType;
    entity RelationsToSAP @readonly as projection on sitreg.RelationToSAP;
    entity Events @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            UpdateRestrinctions: {Updatable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Event;

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
    ) as projection on sitreg.Participant;

    entity Tickets @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Tickets;
    
    entity CoOrganizers @readonly as projection on sitreg.CoOrganizers{
        *,
        Event: redirected to Events
        
    };
    entity Devices @readonly as projection on sitreg.Devices{
        *,
        Event: redirected to Events
    };
    entity PrintQueues @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.PrintQueues{
        *,
        Event: redirected to Events
    };
}
