import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Kirlia extends Pokemon{
	public Kirlia(){
		init();
	}

	public Kirlia(String name, int level){
		super(name, level);
		init();
}

	private void init(){
		setStats(38, 35, 35, 65, 55, 50);
		setType(Type.PSYCHIC, Type.FAIRY);
		setMove(new CalmMind(), new Rest(), new DrainingKiss());
	}
}
