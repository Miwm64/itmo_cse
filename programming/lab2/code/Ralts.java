import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Ralts extends Pokemon{
	public Ralts(){
		init();
	}

	public Ralts(String name, int level){
		super(name, level);
		init();
}

	private void init(){
		setStats(28, 25, 25, 45, 35, 40);
		setType(Type.PSYCHIC, Type.FAIRY);
		setMove(new CalmMind(), new Rest());
	}
}
