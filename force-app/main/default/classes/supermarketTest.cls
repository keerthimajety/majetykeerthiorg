@isTest
public class supermarketTest {
    
    
    
    @istest
    public static void product_details(){
        
        Productmap prod1=new Productmap(01,100,'Biscuit',30.0,5.0);
		Productmap prod2=new Productmap(02,100,'books',75,5.0);
		Productmap prod3=new Productmap(03,100,'apples',20,5.0);
        Productmap prod4=new Productmap(04,100,'banana',20,5.0);
        

		
		 SuperMarket smarket=new Supermarket();
       smarket.eachlist.put(01,prod1);
       smarket.eachlist.put(02,prod1); 
       smarket.eachlist.put(03,prod1); 
       smarket.eachlist.put(04,prod1);
              
        smarket.billing(03,10);
        smarket.product_search(03);
        smarket.stock_display();
    
    
}
}