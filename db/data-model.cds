namespace com.sap.sapmentors.sitregcapm;
using { LanguageCode, Country, managed,User } from '@sap/cds/common';

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
        Location            : String(100) not null;
        EventDate           : Timestamp not null;
        StartTime           : Timestamp;
        EndTime             : Timestamp;
        MaxParticipants     : Integer not null;
        HomepageURL         : String(256);
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