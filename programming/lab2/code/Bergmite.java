import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Bergmite extends Pokemon{
	public Bergmite(){
		super();
		init();
	}

	public Bergmite(String name, int level){
		init();
	}

	private void init(){
		setType(Type.ICE);
		setMove(new DoubleEdge(), new IceFang(), new Facade());
		evolution_init();
	}

	private void evolution_init(){
		setStats(55, 69, 85, 32, 35, 28);
	}
}
