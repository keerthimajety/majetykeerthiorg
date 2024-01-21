import { LightningElement } from 'lwc';

export default class DataBinding extends LightningElement {

    name = 'AJ Skill'
    firstname ='John'
    lastname
    upperC
    price = 40
    person ={
        name: 'mathew',
        age :35,
        place :'sharjah'
    }
    friends =['ravi','ramu','sita']
    get discount(){
        return this.price*0.56

    }
    get friendlist(){
        return this.friends[0]+' '+this.friends[1]+' '+this.friends[2]
    }
    handlechange(event)
    {
        
        if(event.target.name == 'second inputbox')
        this.lastname=event.target.value
        if(event.target.name == 'first inputbox')
        this.firstname=event.target.value
    }
    upperC=this.lastname.toUpperCase();
    
    handleClick(event)
    {
      /*  get display(){
            return 'the firstname is'+this.firstname+'the lastname is'+this.lastname;
        }*/
        
    }
   

    

}