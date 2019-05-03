namespace com.sap.sapmentors.sitregcapm;

using sap from '@sap/cds/common';
using { Language, Country, managed, User } from '@sap/cds/common';

//General types
type URL            : String(256);
type HashT          : Binary(32);
type AnswerOption   : Integer enum { yes = 1; no = 2; maybe = 3; }; 
type DeviceT        : String(36);
type TicketUsedT    : String(1) enum{ YES = 'Y'; NO = 'N'; };
type ActiveT        : String(1) enum{ YES = 'Y'; NO = 'N'; };
type PrintStatusT   : String(1) enum{ QUEUED = 'Q'; SENT = 'S'; PRINTED = 'P' };

abstract entity CodeList {	
    name  : localized String(255) @title:'{i18n>Name}';	
    descr : localized String(1000) @title:'{i18n>Description}';	
}

entity EventTypes : CodeList { key code : String(1); }

entity RelationsToSAP : CodeList { key code : String(1); };

entity Events: managed {
    key ID                  : Integer; 
        tickets             : Association to many Tickets on tickets.events = $self;
        participants        : Association to many Participants on participants.events = $self;
        coOrganizers        : Association to many CoOrganizers on coOrganizers.events = $self;
        devices             : Association to many Devices on devices.events = $self;
        printQueues         : Association to many PrintQueues on printQueues.events = $self;
        location            : String(100) not null;
        eventStart          : Timestamp not null;
        eventEnd            : Timestamp;
        maxParticipants     : Integer not null;
        homepageURL         : URL;
        description         : String(100);
        type                : Association to EventTypes;
        visible             : Boolean;
        hasPreEveningEvent  : Boolean;
        hasPostEveningEvent : Boolean;
};

entity Organizers: managed {
        key UserName          	: User;
            firstName           : String(100) not null;
            lastName        	: String(100) not null;
            eMail            	: String(256) not null;
            mobilePhone       	: String(25);
            status            	: String(1);
            requestTimeStamp    : Timestamp;
            statusSetTimeStamp  : Timestamp;   
};

entity Participants: managed{
    key ID               : Integer;
        events           : Association to Events;
        registrationTime : DateTime;
        firstName        : String(100) not null;
        lastName         : String(100) not null;
        eMail            : String(256) not null;
        mobilePhone      : String(25);
        bioURL           : URL;
        twitter          : String(15);
        rsvp             : Boolean not null; 
        preEveningEvent  : AnswerOption not null; 
        postEveningEvent : AnswerOption not null; 
        relationToSAP    : Association to RelationsToSAP;
        receipt          : Boolean;
        receiptCompany   : String(256);
        receiptAddress   : LargeString;
        tickets          : Association to one Tickets on tickets.participants = $self;
        printQueues      : Association to many PrintQueues on printQueues.participants = $self;
};

entity CoOrganizers : managed {
        key events   : Association to Events;
        key userName : User;
            active   : ActiveT // Y = Yes / N = No
};

entity Devices : managed {
        key events  : Association to Events;
        key deviceID : DeviceT;
            active   : ActiveT // Y = Yes / N = No
};

entity PrintQueues : managed {
        key participants     : Association to Participants;
            events           : Association to Events;
            firstName        : String(100) not null;
            lastName         : String(100) not null;
            twitter          : String(15);
            printStatus      : PrintStatusT not null; // Q = queued, S = sent, P = printed
};

entity Tickets: managed {
    key participants      : Association to Participants;
        events            : Association to Events;
        ticketUsed        : TicketUsedT; // See enum TicketUsedT // Y = used, N not used
        sha256hash        : HashT;        
};




