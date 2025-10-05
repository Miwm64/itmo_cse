import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Battle;
//import Landorus.Landorus;

public class Main{
	public static void  main(String[] args){
		Battle b = new Battle();
		Gallade p1 = new Gallade("First", 1);
		Landorus p2 = new Landorus("Second", 1);
		b.addAlly(p1);
		b.addFoe(p2);
		b.go();
	}
}
