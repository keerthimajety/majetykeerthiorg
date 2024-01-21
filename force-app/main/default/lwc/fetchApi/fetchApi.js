import { LightningElement } from 'lwc';

export default class FetchApi extends LightningElement {


employeeInfo;


handleclick()
{
    let url="https://sfdev36-dev-ed.my.salesforce-sites.com/services/apexrest/employees"
    fetch(url,{method :'GET'})
    .then(response => {
        console.log(response)
        response.json()
        .then(result => {
            this.employeeInfo=result.employee;
            console.log(result)})
            console.log('this is employee array below')
            console.log(result.employee)
        .catch(error=>console.log(error))
    })
    .catch(error =>{
        console.log(error);
    })
}



}