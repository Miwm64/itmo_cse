public class Main {
    public static void main(String[] args) {
		Inherited i = new Inherited();		
    }
}

class Base{
	public Base(){
		System.out.println("Base");
	}
}

class Inherited extends Base{

}
