import { LightningElement ,api} from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import NAME_FIELD from '@salesforce/schema/Account.Name'
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry'
export default class RecordForm extends LightningElement {

    objectName=ACCOUNT_OBJECT
    fields=[NAME_FIELD,INDUSTRY_FIELD]

    @api recordId;
    @api objectApiName;

}