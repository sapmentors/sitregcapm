using com.sap.sapmentors.sitregcapm as sitreg from '../db/data-model';

service PublicService {
    entity Events @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            UpdateRestrinctions: {Updatable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Event;


    entity Participants @( 
            Capabilities: {
            InsertRestrictions: {Insertable: false},
            UpdateRestrinctions: {Updatable: false},
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection  on sitreg.Participant;
    entity CoOrganizers @readonly as projection on sitreg.CoOrganizers{
        *,
        Event: redirected to Events
        
    };
    entity Devices @readonly as projection on sitreg.Devices{
        *,
        Event: redirected to Events
    };
    entity PrintQueues @readonly as projection on sitreg.PrintQueues{
        *,
        Event: redirected to Events
    };
    entity Tickets @readonly as projection on sitreg.Tickets{
        *,
        Event: redirected to Events
    };
    entity EventTypes @readonly as projection on sitreg.EventType;
    entity RelationsToSAP @readonly as projection on sitreg.RelationToSAP;
}
