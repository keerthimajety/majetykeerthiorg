public class  SuperMarket {
    
   public Map<integer,Productmap> eachlist =new Map<integer,Productmap>();
    
 
         
    
    public  void billing(integer code,integer Quantity){
      decimal total_bill;
         if(eachlist.containskey(code))
         {
             total_bill = eachlist.get(code).Price * Quantity;
             eachlist.get(code).stock =eachlist.get(code).stock - Quantity;
             
             //system.debug('total bill '+total_bill);

         }
    }
    /*    for(integer key:eachlist.key())
        {
            if(code==key)
            {
                system.debug()
              /*  if(p.stock>Quantity)
                {
                total_bill = p.Price*Quantity-(p.Price*Quantity*p.Discount/100);
                    p.stock=p.stock-Quantity;
                system.debug('total bill for'+' quantity '+'of'+ProductName+'='+total_bill);
                }
                else
                    system.debug('stock not available');
            }
            /*else
                system.debug('enter the correct product name');
       }*/
  
    
 /*   public void reoder(){
for(Productp p:eachlist)
        {
            if(p.stock<20)
                system.debug('reoder the stock of product'+p.Name);
            else
                system.debug('stock is available for Product'+P.Name);
        }
    }*/
    //map
      public void product_search(integer code){
        for(integer i:eachlist.keyset())
        {
            if(i==code)
            {
                
                system.debug('Name of product is '+eachlist.get(i));
                //system.debug('stock of the product availabe is '+p.Stock);
                
            }
            //else
              //  system.debug('enter the correct code');
        }
    }
    //list
   /* public void product_search(integer code){
        for(Productp p:eachlist)
        {
            if(p.Code==Code)
            {
                system.debug('Name of product is '+p.Name);
                system.debug('stock of the product availabe is '+p.Stock);
                
            }
            else
                system.debug('enter the correct code');
        }
    }
    public void stock_display(){
        for(Productp p:eachlist)
        {
            system.debug(p.Name+'stock is = '+p.stock);
        }
    }
        */
     public void stock_display(){
        for(integer i:eachlist.keyset())
        {  
            integer stockp;
            stockp=eachlist.get(i).stock;
            
            //system.debug(p.Name+'stock is = '+p.stock);
        }
    }

}