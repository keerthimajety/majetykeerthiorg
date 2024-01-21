import { LightningElement,track } from 'lwc';

export default class TodoList extends LightningElement {

   length=0;
   nooftask =0;
   inputboxtext="Enter the task"
    @track
    Tasktodo=[];
    task;
   
   //length =this.Tasktodo.length;
   
   handlechange(event)
   {
    this.task=event.target.value
   }
   handleClick(event)
   {
    this.Tasktodo.push({id :this.Tasktodo.length,name :this.task })
   }
   handleiconclick(event)
   {
   /* let deleteindex;
    alert(event.target.name)
    for(let i=0;i<this.Todotask.length;i++)
    {
      if(this.Tasktodo[i].id == event.target.name)
      deleteindex =i;

    }*/
    this.Tasktodo.splice(this.Tasktodo.findIndex(mytask => mytask.id === event.target.name),1);
    task=" ";
   }
}