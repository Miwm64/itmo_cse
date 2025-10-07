import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Battle;
import java.util.Arrays;

public class Main{
	public static void  main(String[] args){
		Battle b = new Battle();
		Landorus p1 = new Landorus("First", 1);
		Bergmite p2 = new Bergmite("Second", 1);
		Avalugg p3 = new Avalugg("Third", 1);
		Ralts p4 = new Ralts("Fourth", 1);
		Kirlia p5 = new Kirlia("Fifth", 1);
		Gallade p6 = new Gallade("Sixth", 1);
		
		b.addAlly(p1);
		b.addAlly(p2);
		b.addAlly(p3);
		b.addFoe(p4);
		b.addFoe(p5);
		b.addFoe(p6);
		b.go();
	}
}
