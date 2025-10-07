import ru.ifmo.se.pokemon.PhysicalMove;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Type;


public class RockTomb extends PhysicalMove{
	public RockTomb(){
		accuracy = 95;
		power = 60;
		type = Type.ROCK;
	}
	
	@Override
	protected String describe(){
		return "uses RockTomb";
	}

	@Override
	protected void applyOppEffects(Pokemon p){
		p.setMod(Stat.SPEED, -1);

	}
}
