import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Gallade extends Pokemon{
	public Gallade(){
		init();
	}

	public Gallade(String name, int level){
		super(name, level);
		init();
}

	private void init(){
		setStats(68, 125, 65, 65, 115, 80);
		setType(Type.PSYCHIC, Type.FIGHTING);
		setMove(new CalmMind(), new Rest(), new DrainingKiss(), new Confide());
	}
}
