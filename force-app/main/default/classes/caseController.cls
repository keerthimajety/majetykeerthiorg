public with sharing class caseController {
   @AuraEnabled
   public static string  cloneCase(string recordid){
    case cas = [SELECT Origin, accountid FROM Case LIMIT 1];

    Case Copy = cas.clone(false, false, false, false);
    insert Copy;
    system.debug(Copy.Id);
    return Copy.Id;
   }
}