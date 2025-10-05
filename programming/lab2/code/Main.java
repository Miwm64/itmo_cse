import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Battle;
//import Landorus.Landorus;

public class Main{
	public static void  main(String[] args){
		Battle b = new Battle();
		Landorus p1 = new Landorus();
		Landorus p2 = new Landorus();
		b.addAlly(p1);
		b.addFoe(p2);
		b.go();
	}
}
