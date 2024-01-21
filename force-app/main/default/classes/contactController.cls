public with sharing class contactController {
   /* @AuraEnabled
    public static string insertcontact(string lastname,string mobile)
    {

        Contact newcon=new Contact(Lastname=lastname,MobilePhone=mobile);
        insert newcon;
        return newcon.Id;
    }*/
  @AuraEnabled(cacheable=true)
  public static list<Contact> getContactList(Id accId)
  {
    List<contact> conlist=[Select Id,LastName from Contact where AccountId = :accId];
    return conlist;
  }

}