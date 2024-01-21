public class Banking {

    public static double depositamount=100;
    public static double withdrawamount=10,Balance=1000 ;
    public static void withdrawal(){
        system.debug('withdrawal amount is '+withdrawamount);
        system.debug('current balance is '+(Balance-withdrawamount));
    }
    public static void deposit(){
        system.debug('deposit amount is '+ depositamount);
        system.debug('current balance is '+(Balance+depositamount));
    }
    
    
}