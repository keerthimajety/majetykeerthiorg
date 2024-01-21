import { LightningElement,api } from 'lwc';

export default class SliderComponent extends LightningElement {

    @api
    slidervalue;
    @api
    resetslider(){
        this.slidervalue=0;
    }
    

}