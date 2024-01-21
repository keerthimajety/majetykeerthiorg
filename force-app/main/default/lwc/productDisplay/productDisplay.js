import { LightningElement ,track} from 'lwc';

export default class ProductDisplay extends LightningElement {
display=true
@track
product = {
    name : 'p01',
    price : 200,
    stock  :150 
}
handlechange(event){
    
    
    if(event.target.value == '0')
    {
       this.display =false
    }
    else
    {
        this.display =true
        this.product.stock =event.target.value
    
    }
}

}