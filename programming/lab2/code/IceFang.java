import ru.ifmo.se.pokemon.PhysicalMove;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Effect;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Status;
import ru.ifmo.se.pokemon.Type;
import java.util.Random;


public class IceFang extends PhysicalMove{
	public IceFang(){
		accuracy = 95;
		power = 65;
		type = Type.ICE;
	}

	@Override	
	protected String describe(){
		return "uses IceFang";
	}
	
	@Override
	protected void applyOppEffects(Pokemon p){		
		Random random = new Random();
		double freeze_chance = random.nextFloat();
		double flinch_chance = random.nextFloat();
		if (freeze_chance > 0.9) {
			Effect.freeze(p);
		}
		if (flinch_chance > 0.9){
			Effect.flinch(p);	
		}
	}
}
