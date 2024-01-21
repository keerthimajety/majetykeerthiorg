import { LightningElement } from 'lwc';

export default class Septpractice extends LightningElement {


result
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
        },2000)
    })
    }

    chk_pwd(num)
{

    return new Promise((resolve,reject)=>
    {
        setTimeout(()=>{
            if(str ==1234)
            resolve("verified pwd")
        else
        reject("not authorized")
        },2000)
    })
    }
async handleclick(event)
{
    try {
    let response=await chk_string("Ajskill");

    }
    catch(error){
    console.log(error);
    }
}






}