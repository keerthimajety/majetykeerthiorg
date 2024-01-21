/***********************************************************************
Name        Numberlist
author      keerthi
date        4-1-2023
Description day 6 diy set three products and functions for billing and reoder stock and search product
*************************************************************************/


public class Product {

    public string ProductCode,ProductName;
    public decimal ProductPrice,DiscountPercent;
    public integer StockQuantity;
    
    public  Product(integer current_stock, string productcode,string ProductName,decimal ProductPrice,decimal Discount){
        stockQuantity=current_stock;
        ProductCode=productcode;
        this.ProductName=ProductName;
        this.ProductPrice=ProductPrice;
        DiscountPercent=Discount;
        system.debug('current stock of the product'+ProductCode+'is '+stockQuantity);
    }
    public void billing(string ProductName,integer Quantity){
        decimal TotalBill;
        StockQuantity=StockQuantity-Quantity;
        //this.DiscountPercent=DiscountPercent;
        //this.ProductPrice=ProductPrice;
        TotalBill=(ProductPrice*Quantity)-(ProductPrice*DiscountPercent/100);
        system.debug('product name ='+this.ProductName);
        system.debug('No of units ='+ Quantity);
        system.debug('Price of product='+ProductPrice);
        system.debug('discount percentage ='+DiscountPercent+ '%');
        system.debug('Total bill Amount = '+TotalBill);
        system.debug('currentStock='+StockQuantity );
    }
  
    
    public void ProductSearch(string ProductCode)
    {
        If(ProductCode==this.ProductCode)
        {
            system.debug('ProductName  is '+ProductName);
            system.debug('currentstock= ' +StockQuantity);
        }
    }
    public void disp_reoderstock(){
        integer reoder_stock;
        If(StockQuantity<20)
            system.debug('Product name'+ ProductName+'has to be reodered');
        else
            system.debug('Stock available');
    }
    
}