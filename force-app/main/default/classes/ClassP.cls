public virtual class ClassP {

    public void display1()
    {
        system.debug('parent class first function');
    }
    public void display2()
    {
        system.debug('parent class second function');
        display1();
    }
   
}