import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Gallade extends Kirlia{
	public Gallade(){
		super();
	}

	public Gallade(String name, int level){
		super(name, level);
	}

	@Override
	protected void evolution_init(){
		setStats(68, 125, 65, 65, 115, 80);
		addType(Type.FIGHTING);
		addMove(new DrainingKiss());
		addMove(new Confide());
	}
}
