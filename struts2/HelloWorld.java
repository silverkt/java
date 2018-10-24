public class HelloWorld
{
	public int a;
	public String str = "shit";
	public static void main(String []args) {
		System.out.println("HelloWorld");
		HelloWorld abc = new HelloWorld();
		abc.prints();

	}

	public void prints() {
		System.out.println(this.str);
	}
}