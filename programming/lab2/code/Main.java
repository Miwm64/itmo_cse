import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Battle;
//import Landorus.Landorus;

public class Main{
	public static void  main(String[] args){
		Battle b = new Battle();
		Gallade p1 = new Gallade("First", 1);
		Bergmite p2 = new Bergmite("Second", 1);
		b.addAlly(p1);
		b.addFoe(p2);
		b.go();
	}
}
