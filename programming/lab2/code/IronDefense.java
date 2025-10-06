import ru.ifmo.se.pokemon.StatusMove;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Type;


public class IronDefense extends StatusMove{
	public RockTomb(){
		type = Type.STEEL;
	}
	
	protected String describe(){
		return "uses IronDefense";
	}
	
	protected void applySelfEffects(Pokemon p){
		p.setMod(Stat.DEFENSE, +2);

	}
}
