using com.sap.sapmentors.sitregcapm as sitreg from '../db/data-model';

service OrganizerService {
   entity EventTypes @readonly as projection on sitreg.EventTypes;
    entity RelationsToSAP @readonly as projection on sitreg.RelationsToSAP;
    entity Events @(
        Capabilities: {
            DeleteRestrictions: {Deletable: false}
        }
    ) as projection on sitreg.Events;      
    entity Organizers as projection on sitreg.Organizers;
    entity CoOrganizers as projection on sitreg.CoOrganizers;
    entity Participants @readonly as projection on sitreg.Participants;
    entity Devices @readonly as projection on sitreg.Devices;
    entity PrintQueues as projection on sitreg.PrintQueues;
    entity Tickets as projection on sitreg.Tickets;    
}