import ru.ifmo.se.pokemon.Type;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.StatusMove;


public class Confide extends StatusMove{
	public Confide(){
		type = Type.NORMAL;
	}
	
	@Override	
	protected String describe(){
		return "uses Confide";
	}

	@Override
	protected void applyOppEffects(Pokemon p){
		p.setMod(Stat.SPECIAL_ATTACK, -1);
	}
}
