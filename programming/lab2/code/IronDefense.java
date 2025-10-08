import ru.ifmo.se.pokemon.StatusMove;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Type;
import java.util.Arrays;

public class IronDefense extends StatusMove{
	public IronDefense(){
		type = Type.STEEL;
	}
	
	@Override	
	protected String describe(){
		return "uses IronDefense";
	}
	
	@Override
	protected void applySelfEffects(Pokemon p){
		p.setMod(Stat.DEFENSE, +2);
	}
}
