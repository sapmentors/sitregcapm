using com.sap.sapmentors.sitregcapm as sitreg from '../db/data-model';

service AdminService {
    entity EventTypes @readonly as projection on sitreg.EventTypes;
    entity RelationsToSAP @readonly as projection on sitreg.RelationsToSAP;
}
