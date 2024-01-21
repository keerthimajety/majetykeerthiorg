import { LightningElement } from 'lwc';

export default class WelcomeMessage extends LightningElement {

    Message;
    colour ;

    handleClick(event){

        if(event.target.label=='Green')
        {
            this.colour ='style1'
            console.log(event.target.label)
        }
        
        if(event.target.label =='Blue')
        this.colour = 'style2'
         
    }
}