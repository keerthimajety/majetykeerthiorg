import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {
   slidervalue;
    handlechange(event)
    {
      this.slidervalue=event.target.value
    }
    handleclick(event)
    {

        this.slidervalue=" ";
        this.template.querySelector('c-slider-component').resetslider();
    }
}