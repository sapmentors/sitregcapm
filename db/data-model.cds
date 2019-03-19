namespace com.sap.sapmentors.sitregcapm;
using { LanguageCode, Country, managed,User } from '@sap/cds/common';

//General types
type URL            : String(256);
type HashT          : Binary(32);
type AnswerOption   : Integer enum { yes = 1; no = 2; maybe = 3; }; 
type DeviceT        : String(36);
type TicketUsedT    : String(1) enum{ YES = 'Y'; NO = 'N'; };
type ActiveT        : String(1) enum{ YES = 'Y'; NO = 'N'; };
type PrintStatusT   : String(1) enum{ QUEUED = 'Q'; SENT = 'S'; PRINTED = 'P' };

// @cds.autoexpose @cds.persistence.skip:'if-unused'
abstract entity CodeList {
    name  : localized String(255) @title:'{i18n>Name}';
    descr : localized String(1000) @title:'{i18n>Description}';
}

entity EventTypes : CodeList { key code : String(1); }

entity RelationsToSAP {
    key ID : String(1);
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

entity Events: managed {
    key ID                  : Integer; 
        Tickets             : Association to many Tickets on Tickets.Events = $self;
        Participants        : Association to many Participants on Participants.Events = $self;
        CoOrganizers        : Association to many CoOrganizers on CoOrganizers.Events = $self;
        Devices             : Association to many Devices on Devices.Events = $self;
        PrintQueues         : Association to many PrintQueues on PrintQueues.Events = $self;
        Location            : String(100) not null;
        EventStart          : Timestamp not null;
        EventEnd            : Timestamp;
        MaxParticipants     : Integer not null;
        HomepageURL         : URL;
        Description         : String(100);
        Type                : Association to EventTypes;
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

entity Participants: managed{
    key ID               : Integer;
        Events            : Association to Events;
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
        RelationToSAP    : Association to RelationsToSAP;
        Receipt          : Boolean;
        ReceiptCompany   : String(256);
        ReceiptAddress   : LargeString;
        Tickets          : Association to many Tickets on Tickets.Participants = $self;
        PrintQueues      : Association to many PrintQueues on PrintQueues.Participants = $self;
};

entity CoOrganizers : managed {
        key Events  : Association to Events;
        key UserName : User;
            Active   : ActiveT // Y = Yes / N = No
};

entity Devices : managed {
        key Events  : Association to Events;
        key DeviceID : DeviceT;
            Active   : ActiveT // Y = Yes / N = No
};

entity PrintQueues : managed {
        key Participants      : Association to Participants;
            Events            : Association to Events;
            FirstName        : String(100) not null;
            LastName         : String(100) not null;
            Twitter          : String(15);
            PrintStatus      : PrintStatusT not null; // Q = queued, S = sent, P = printed
};

entity Tickets: managed {
    key Participants      : Association to Participants;
        Events            : Association to Events;
        TicketUsed       : TicketUsedT; // See enum TicketUsedT // Y = used, N not used
        SHA256HASH       : HashT;        
};




