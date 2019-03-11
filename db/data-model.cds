namespace com.sap.sapmentors.sitregcapm;
using { LanguageCode, Country, managed,User } from '@sap/cds/common';

//General types
type URL: String(256);
type HashT          : Binary(32);
type AnswerOption: Integer enum { yes = 1; no = 2; maybe = 3; }; 
type DeviceT : String(36);
type TicketUsedT    : String(1) enum{ YES = 'Y'; NO = 'N'; };

// @cds.autoexpose @cds.persistence.skip:'if-unused'
abstract entity CodeList {
    name  : localized String(255) @title:'{i18n>Name}';
    descr : localized String(1000) @title:'{i18n>Description}';
}

entity EventType  : CodeList { key code : String(1); }

entity RelationToSAP {
    key RelationToSAP : String(1);
    /**
    Fieldname Language results in this error in the cds run output:
    An error occurred: An error occurred during serialization of the entity collection
    And this error when calling the OData Endpoint:
    An error occurred during serialization of the entity collection An error occurred 
    during serialization of the entity at index #0 in the entity collection The entity 
    contains 'LANGUAGE' property, which does not belong neither to the structural nor 
    to the navigation properties of the 'RelationsToSAP' type
    */ 
    key Lang : LanguageCode;
    Description  : String(250);
};

entity Event: managed {
    key ID                  : Integer; 
        Tickets             : Association to many Tickets on Tickets.Event = $self;
        Location            : String(100) not null;
        EventStart          : Timestamp not null;
        EventEnd            : Timestamp;
        MaxParticipants     : Integer not null;
        HomepageURL         : URL;
        Description         : String(100);
        Type                : Association to EventType;
        Visible             : Boolean;
        HasPreEveningEvent  : Boolean;
        HasPostEveningEvent : Boolean;
};

entity Organizers: managed {
        key UserName          	: User;
            FirstName           : String(100) not null;
            LastName        	: String(100) not null;
            EMail            	: String(256) not null;
            MobilePhone       	: String(25);
            Status            	: String(1);
            RequestTimeStamp    : Timestamp;
            StatusSetTimeStamp  : Timestamp;   
};

entity Participant: managed{
    key ID               : Integer;
        Event            : Association to Event;
        RegistrationTime : DateTime;
        FirstName        : String(100) not null;
        LastName         : String(100) not null;
        EMail            : String(256) not null;
        MobilePhone      : String(25);
        BioURL           : URL;
        Twitter          : String(15);
        RSVP             : Boolean not null; 
        PreEveningEvent  : AnswerOption not null; 
        PostEveningEvent : AnswerOption not null; 
        RelationToSAP    : Association to RelationToSAP;
        Receipt          : Boolean;
        ReceiptCompany   : String(256);
        ReceiptAddress   : LargeString;
};

entity CoOrganizers : managed {
        key EventID  : Association to Event;
        key UserName : User;
            Active   : String(1); // Y = Yes / N = No
};

entity Devices : managed {
        key EventID  : Association to Event;
        key DeviceID : DeviceT;
            Active   : String(1); // Y = Yes / N = No
};

entity PrintQueues : managed {
        key ParticipantID    : Association to Participant;
            EventID          : Association to Event;
            FirstName        : String(100) not null;
            LastName         : String(100) not null;
            Twitter          : String(15);
            PrintStatus      : String(1) not null; // Q = queued, S = sent, P = printed
};

entity Tickets: managed {
    key Participant      : Association to Participant;
        Event            : Association to Event;
        TicketUsed       : TicketUsedT; // See enum TicketUsedT // Y = used, N not used
        SHA256HASH       : HashT;        
};
