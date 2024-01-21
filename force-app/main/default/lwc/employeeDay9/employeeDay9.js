import { LightningElement ,track} from 'lwc';

export default class EmployeeDay9 extends LightningElement {

@track
employee =[{
    name : 'sanjay',
    salary:40000,
    position :'developer'
},
{
    name : 'sahuja',
    salary:50000,
    position :'analyst'
},
{
    name : 'sarkar',
    salary:60000,
    position :'admin'
},
{
    name : 'mehta',
    salary:70000,
    position :'developer'
}
]
@track
displayemployee =[];
showMessage=false
salaryEntered
handlechange(event)
{
   //this.displayemployee=this.employee.filter((singleemployee)=> singleemployee.salary > parseInt(event.target.value))
    this.salaryEntered=parseInt(event.target.value)

   

 /* if(this.displayemployee.length ==0)
  {
    showMessage=false
  }*/
  //this.displayemployee =this.employee

}
handleClick(event)
{
    this.displayemployee=this.employee.filter((singleemployee)=> singleemployee.salary > this.salaryEntered) 
}
}