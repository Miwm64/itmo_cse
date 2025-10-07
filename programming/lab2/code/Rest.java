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
	
	@Override
	protected String describe(){
		return "uses Rest";
	}

	@Override
	protected void applySelfEffects(Pokemon p){
		p.restore();
		System.out.println("Health restored");
		Effect e = new Effect().chance(1).turns(2).condition(Status.SLEEP);
		e.attack(0);
		p.setCondition(e);

	}
}
