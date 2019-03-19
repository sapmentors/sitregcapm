using com.sap.sapmentors.sitregcapm as sitreg from '../db/data-model';

service AdminService @(requires:'admin') {
    entity EventTypes @readonly as projection on sitreg.EventTypes;
    entity RelationsToSAP @readonly as projection on sitreg.RelationsToSAP;
    entity Events @(
        Capabilities: {
            InsertRestrictions: {Insertable: false},
            DeleteRestrictions: {Deletable: false}
        }


    ) as projection on sitreg.Events;      
    entity Organizers as projection on sitreg.Organizers;
    entity CoOrganizers as projection on sitreg.CoOrganizers{
        *,
        events: redirected to Events
        
    };
    entity Participants @(        
        Capabilities: {
            InsertRestrictions: {Insertable: false},
            UpdateRestrinctions: {Updatable: false},
            DeleteRestrictions: {Deletable: false}

        }
    ) as projection on sitreg.Participants{
        *,
        events: redirected to Events
    };
    entity Devices as projection on sitreg.Devices{
        *,
        events: redirected to Events
    };
    entity PrintQueues as projection on sitreg.PrintQueues{
        *,
        events: redirected to Events
    };
    entity Tickets as projection on sitreg.Tickets{
        *,
        events: redirected to Events
    };
    entity ParticipantsPerEventRead as projection on sitreg.Events{ 
        ID, 
        location, 
        eventStart, 
        eventEnd, 
        maxParticipants, 
        homepageURL
    };

}

