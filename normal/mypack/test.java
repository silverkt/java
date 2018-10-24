package mypack;
import jtest.Timport;



class Test {
    public static void main(String args[]) {
        System.out.println("System out");
        Called a = new Called();
        a.callout();
    }
}


class Called {
   
    public void callout() {
        System.out.println("calledout");

        for(int n=0; n<10000; n++) {
            System.out.println(n);
        }
        Timport obj1 = new Timport();
        // obj1 = new Timport();
        
		System.out.println(obj1.printtest());


    }
}