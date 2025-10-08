import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Bergmite extends Pokemon{
	public Bergmite(){
		init();
	}

	public Bergmite(String name, int level){
		super(name, level);
		init();
	}

	protected void init(){
		setType(Type.ICE);
		setMove(new DoubleEdge(), new IceFang(), new Facade());
		evolution_init();
	}

	protected void evolution_init(){
		setStats(55, 69, 85, 32, 35, 28);
	}
}
