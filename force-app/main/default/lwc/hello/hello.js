import { LightningElement } from 'lwc';

export default class Hello extends LightningElement {

    result;
z=100;

//promise function
chk_string(str)
{

    return new Promise((resolve,reject)=>
    {
        setTimeout(()=>{
            if(str =='Ajskill')
            resolve("verified username")
        else
        reject("not matching")
        },5000)
    })
    }

    chk_pwd(num)
{

    return new Promise((resolve,reject)=>
    {
        setTimeout(()=>{
            if(num ==1234)
            resolve("verified pwd")
        else
        reject("not authorized")
        },2000)
    })
    }
/*async handleclick(event)
{
    alert("inside handleclick function")
    try {
    const response=await this.chk_string("Ajskill");
    this.result=response;
    alert("match")
    const response2=await this.chk_pwd(1234);
    alert(response2)

    }
    catch(error){

        this.result=error
    console.log(error);
    alert(error)
    }
}*/

handleclick(event)
{
    alert("inside handle click")
    const v=this.template.querySelector("lightning-button[data-btn]").variant;
    this.result=v;
    console.log(v);
    this.template.querySelector("lightning-input[data-id1]").value = "enter the text"
    console.log(this.template.querySelector("lightning-input[data-id1]").value)
    console.log(event.target.dataset)
}


}