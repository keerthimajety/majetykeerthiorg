import { LightningElement, api,wire } from 'lwc';
import getContactList from '@salesforce/apex/contactController.getContactList'

export default class CaseStudy3 extends LightningElement {

    //ContactList;
    coloumnList = [
        {label : 'Id',fieldName :'Id'},
        {label : 'Name',fieldName :'LastName'}
        
    ];
    @api 
    recordId
    @wire(getContactList,{accId : "$recordId"})
    ContactList;
    handleclick(event)
    {
        console.log(this.ContactList.data);
    }

}