import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Type;
import java.util.Arrays;


public class Kirlia extends Ralts{
	public Kirlia(){
		super();	
	}

	public Kirlia(String name, int level){
		super(name, level);
	}

	@Override	
	protected void evolution_init(){
		setStats(38, 35, 35, 65, 55, 50);
		addType(Type.FAIRY);
		addMove(new DrainingKiss());
	}
}
