import { LightningElement } from 'lwc';
import accountTemplate from './accountTemplate.html'
import contactTemplate from './contactTemplate.html'
import dynamicTemplate from './dynamicTemplate.html'

export default class DynamicTemplate extends LightningElement {

 data=0;
    handleclickacc(){

    this.data=1;
    }
    handleclickcon(){
this.data=2;

    }
    exit(){

        this.data=0;
    }
    render(){
        if(this.data==1)
        return accountTemplate
    if(this.data==2)
    return contactTemplate
    else
    return dynamicTemplate
    }


}