import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;
import java.util.Arrays;


public class Ralts extends Pokemon{
	public Ralts(){
		init();
	}

	public Ralts(String name, int level){
		super(name, level);
		init();
	}

	public void init(){	
		setType(Type.PSYCHIC);
		setMove(new CalmMind(), new Rest());
		evolution_init();
	}

	protected void evolution_init(){
		addType(Type.FAIRY);
		setStats(28, 25, 25, 45, 35, 40);
	}
}
