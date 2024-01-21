import { LightningElement,track } from 'lwc';

export default class EmployeeInfo extends LightningElement {
    enteredstr;
    filteredEmplist;
   @track
    employeeinfo=[{
        Id:1,
        name:"sarveshwar"},
        {
            Id:2,
            name :"pasupati"
        },
        {
            id:3,
            name:"parvati"
        },
        {
            id:4,
            name:"pavitra" 
        },
        {
            id:5,
            name:"parrot" 
        },
        {
            id:6,
            name:"saadvi" 
        },
        {
            id:7,
            name:"digo" 
        },
        {
            id:8,
            name:"john" 
        },
        {
            id:9,
            name:"diger" 
        },
        {
            id:10,
            name:"sampath" 
        }
    ]
   
    handlechange(event)
    {
        this.enteredstr = event.target.value;
        console.log(event.target.value)
        console.log(this.enteredstr);
    }
     handleClick(event)
    {
       this.filteredEmplist=this.employeeinfo.filter((singleemployee) => {let s=singleemployee.name;
        
    if(s.startsWith(this.enteredstr))
    return true;
else 
return false} )
console.log(this.filteredEmplist)
      
    }
    


}