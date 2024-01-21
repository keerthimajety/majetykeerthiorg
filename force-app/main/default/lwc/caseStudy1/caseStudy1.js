import { LightningElement } from 'lwc';

export default class CaseStudy1 extends LightningElement {

    style;
handleclick(event)
{
    if(event.target.name == 'Format1')
  this.style ="style1"
   if(event.target.name == 'Format2')
    this.style='style2'
   if(event.target.name == 'Format3')
   this.style='style3'
}
}