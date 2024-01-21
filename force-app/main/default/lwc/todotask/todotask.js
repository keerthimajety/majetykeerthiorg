import { LightningElement,track } from 'lwc';

export default class Todotask extends LightningElement {

@track
    todotask=[];
    task;
    handlechange(event)
    {
      /* this.todotask.push({id: this.todotask.length,
                            name : event.target.value})*/
                            this.target.task=event.target.value;
    }
    handleclick(event)
    {
        this.todotask.push({id: this.todotask.length,
            name : this.target.task})
            this.task=' ';
    }
    handledeletebutton(event)
    {
        
    }
}