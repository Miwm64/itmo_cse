import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;

public class Avalugg extends Pokemon{
	public Avalugg(){
		init();
	}

	public Avalugg(String name, int level){
		super(name, level);
		init();
}

	private void init(){
		setStats(89, 125, 90, 115, 80, 101);
		setType(Type.GROUND, Type.FLYING);
		setMove(new EarthPower(), new BrutalSwing(), new RockTomb(), new Rest());
		//setMove(new EarthPower(), new BrutalSwing(), new RockTomb());
	}
}
