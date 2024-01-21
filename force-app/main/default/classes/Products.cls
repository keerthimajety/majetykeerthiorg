public class Products {
    public string product1='P01',product2='P02',product3='P03',ProductName ;
    public decimal DiscountPercent=10,Price1=500,Price2=1000,Price3=700;
    public integer stock_product1=100,stock_product2=200,stock_product3=300;
    
    public void billing(string product,integer quantity)
    {
        decimal TotalBill;
        if(Product==this.product1)
        {
            
            TotalBill=quantity*price1;
            stock_product1=stock_product1-quantity;
        system.debug('product name is earphones');
        system.debug('No of units ='+ quantity);
        system.debug('Price of product= '+Price1);
        system.debug('discount percentage ='+DiscountPercent+ '%');
        system.debug('Total bill Amount = '+TotalBill);
        system.debug('currentStock='+ stock_product1 );
        }
        else
        {
            if(product==product2){
         
                 
            TotalBill=(quantity*price2)-((quantity*price2)*10/100);
            stock_product2=stock_product2-quantity;
        system.debug('product name is bag');
        system.debug('No of units ='+ quantity);
        system.debug('Price of product= '+Price2);
        system.debug('discount percentage ='+DiscountPercent+ '%');
        system.debug('Total bill Amount = '+ TotalBill);
        system.debug('currentStock='+ stock_product2 );  
               }
        else
        {
            stock_product3=stock_product3-quantity;
        system.debug('product name is googles');
        system.debug('No of units ='+ quantity);
        system.debug('Price of product= '+Price3);
        system.debug('discount percentage ='+DiscountPercent+ '%');
        system.debug('Total bill Amount = '+TotalBill);
        system.debug('currentStock='+ stock_product3 );  
        }
        }
    }
    public void SearchProduct(string code)
    {
        if(code==product1)
        {
            system.debug('product name is earphones');
            system.debug('currentStock='+ stock_product1 );
        }
        else
        {
            if(code==product1)
        {
            system.debug('product name is bag');
            system.debug('currentStock='+ stock_product2 );
        }
            else
            {
                
            system.debug('product name is googles');
            system.debug('currentStock='+ stock_product3 );
        
            }
        }
           
        }
    public void reoderstock(){
        if(stock_product1<20 || stock_product2<20 ||stock_product3<20)
        {
            if(stock_product1<20)
                system.debug('ear phones has to be reodered');
            
                else
            {
                if(stock_product2<20)
                system.debug('bags has to be reodered');
                 else
                    
                system.debug('googles has to be reodered');

                    
                
            }
            
            
        }
        else
        {
            system.debug('stock available for all three products');
            
        }
    }
}