public class Queueablediy2 implements queueable{

    public void execute(queueableContext ctx)
    {
        list<Account> acclst=[Select Id,Name from Account where CreatedDate=LAST_YEAR];
        system.debug(acclst);
        delete acclst;
    }
}