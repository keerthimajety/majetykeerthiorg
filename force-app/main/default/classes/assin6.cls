public class assin6 {

    
    public contact acc_con(string Name1,Integer num1,string lastname1,integer num2)
    {
        Account acc=new Account(Name=Name1);
        insert acc;
        Contact con=new Contact(LastName=lastname1,AccountId=acc.Id);
        insert con;
        return con;
        
    }
    
    public Id create_Blood_Donor(string name1,Decimal weight,string bloodgrp,Date dateofbirth){
        
       Blood_donor__c bd=new Blood_donor__c(donor_name__c=name1,weight__c=weight,blood_group__c =bloodgrp,DOB__c=dateofbirth) ;
            Insert bd;
        return bd.Id;
            
    }
     public Id create_Blood_Request(string attname1,string pname,String Name2){
      
         blood_request__c br=new blood_request__c(Name=Name2,patient_name__c =pname,attender_name__c=attname1);
         insert br;
         return br.Id;
     
            
    }
    public void Create_blood_Coord(Id brId,Id bdId)
    {
        Blood_Coordination__c bc=new Blood_Coordination__c(patient__c=brId,Donor__c=bdId);
        insert bc;
    }
}
/*anonymus code
 * assin6 a6=new assin6();
Id blooddonorId=a6.create_Blood_Donor('ravi',80,'O POSITIVE',Date.newInstance(1986, 02, 19));
Id bloodrequestId=a6.create_Blood_Request('radha','poonam','sharma');
a6.Create_blood_Coord(bloodrequestId,blooddonorId);*/