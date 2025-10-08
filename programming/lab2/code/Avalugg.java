import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Avalugg extends Bergmite{
	public Avalugg(){
		super();
	}

	public Avalugg(String name, int level){
		super(name, level);
	}

	@Override
	protected void evolution_init(){
		setStats(95, 117, 184, 44, 46, 28);
		addMove(new IronDefense());
	}
}
