namespace com.sap.sapmentors.sitregcapm;
using { LanguageCode, Country, managed } from '@sap/cds/common';

type EventType : String(1);
type RelationToSAP : String(1);

// @cds.autoexpose @cds.persistence.skip:'if-unused'
abstract entity CodeList {
    name  : localized String(255) @title:'{i18n>Name}';
    descr : localized String(1000) @title:'{i18n>Description}';
}

entity EventTypes  : CodeList { key code : EventType; }

entity RelationsToSAP {
    key RelationToSAP : RelationToSAP;
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