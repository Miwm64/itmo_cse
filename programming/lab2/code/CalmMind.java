import ru.ifmo.se.pokemon.StatusMove;
import ru.ifmo.se.pokemon.Type;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Stat;


public class CalmMind extends StatusMove{
	public CalmMind(){
		type = Type.PSYCHIC;
	}

	@Override	
	protected String describe(){
		return "uses CalmMind";
	}
	
	@Override
	protected void applySelfEffects(Pokemon p){
		p.setMod(Stat.SPECIAL_ATTACK, 1);
		p.setMod(Stat.SPECIAL_DEFENSE, 1);
	}
}
