public class apexws7 {

    public void create_n_acc(integer count)
    {
        for(integer i=0;i<count;i++)
        {
            Account Acc=new Account(Name = 'Testday7'+i);
            insert Acc;
        }
    }
}