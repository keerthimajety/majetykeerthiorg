public class schematest {
    
    public static void get_objects(list<string> objectlist)
    {   
       //objectmap has objects as keys and objectype as value    
        Map<String,Schema.SObjectType> objectmap=Schema.getGlobalDescribe();
        
        for(string s:objectmap.keyset())
        {
           if(objectlist.contains(s))
            
           {

              
               sObjectType obj=objectmap.get(s);
               //object properties for particular object
              Schema.DescribeSObjectResult objprop = obj.getDescribe();
                  //to display only customobjects
               if(objprop.iscustom() == true)
               {
               system.debug('Object name = '+s+'----'+'object type = '+ objectmap.get(s));
               system.debug(objprop.label);
                
               }
               //display object label/Name
               system.debug('----------------'+objprop.label+'-------------------');
               //get  field names for this particular object
               Map<string,schema.SobjectField> fieldresult=objprop.fields.getMap();
               //iterate each field
               for(string str:fieldresult.keyset())
               {
                   //for each field get the properties
                   Schema.DescribeFieldResult fieldprop = fieldresult.get(str).getdescribe();
                   //Display the datatype of the field
                   system.debug(str+ '  type = '+fieldprop.getType());
                   //check if the field type is picklist a
                   Switch on fieldprop.getType()
                   {
                       //If the field type is picklist display the picklist values.
                     When PICKLIST  
                     {
                         for(Schema.PicklistEntry pe:fieldprop.getPicklistValues())
                         {
                             system.debug(pe.getLabel()); 
                         }
                         
                     }
                   }
                   
                   
                  
                  // if(fieldprop.gettype() == 'picklist')
                   //system.debug(fieldresult.get(str));
               }
               
            }
            
        }
    }

}

/*
 *list<Schema.sObjectField> dfr = obj.getDescribe().fields.getMap().values();
               for(schema.SObjectField sf:dfr)
               {
                   system.debug(sf);
               }*/