import { LightningElement } from 'lwc';

export default class ModalDemo extends LightningElement {

    componentview=true;
handleclick(){
this.componentview=false;
}
handlemodal(){
this.componentview=true;
}
handlesuccess(event)
{

}
    handlesubmit(event)
    {
        
    }
}