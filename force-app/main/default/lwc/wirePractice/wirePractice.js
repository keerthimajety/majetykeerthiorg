import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { LightningElement ,wire,api} from 'lwc';


export default class WirePractice extends LightningElement {


    @api recordId
   // @api ObjectApiName
   AccountInfo;

    @wire(getObjectInfo,{ObjectApiName :'Account' })
    AccountInfo(response)
    {
        console.log(response);
        this.AccountInfo=response.data;
    }

    handleclick()
    {
        console.log(this.AccountInfo);
    }
}