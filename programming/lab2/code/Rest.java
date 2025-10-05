import ru.ifmo.se.pokemon.StatusMove;
import ru.ifmo.se.pokemon.Type;
import ru.ifmo.se.pokemon.Effect;
import ru.ifmo.se.pokemon.Status;
import ru.ifmo.se.pokemon.Pokemon;

public class Rest extends StatusMove{
	public Rest (){
		type = Type.PSYCHIC;
		accuracy = 1;
	}
	
	protected String describe(){
		return "uses Sleep";
	}

//	public final void attack(Pokemon att, Pokemon def){
//		applySelfEffects(att);	
//	}

	protected void applySelfEffects(Pokemon p){
		p.restore();
		Effect e = new Effect().chance(1).turns(1).condition(Status.SLEEP);
		e.attack(0);
		p.setCondition(e);

	}
}
