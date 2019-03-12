using com.sap.sapmentors.sitregcapm as sitreg from '../db/data-model';

service AdminService {
    entity EventTypes @readonly as projection on sitreg.EventType;
    entity RelationsToSAP @readonly as projection on sitreg.RelationToSAP;
    entity Events @(
        Capabilities: {
            InsertRestrictions: {Insertable: false},
            DeleteRestrictions: {Deletable: false}
        }


    ) as projection on sitreg.Event;      
    entity Organizers as projection on sitreg.Organizers;
    entity CoOrganizers as projection on sitreg.CoOrganizers{
        *,
        Event: redirected to Events
        
    };
    entity Participants @(        
        Capabilities: {
            InsertRestrictions: {Insertable: false},
            UpdateRestrinctions: {Updatable: false},
            DeleteRestrictions: {Deletable: false}

        }
    ) as projection on sitreg.Participant{
        *,
        Event: redirected to Events
    };
    entity Devices as projection on sitreg.Devices{
        *,
        Event: redirected to Events
    };
    entity PrintQueues as projection on sitreg.PrintQueues{
        *,
        Event: redirected to Events
    };
    entity Tickets as projection on sitreg.Tickets{
        *,
        Event: redirected to Events
    };
    entity ParticipantsPerEventRead as projection on sitreg.Event{ ID, Location, EventStart, EventEnd, MaxParticipants, HomepageURL} ;



    
}

