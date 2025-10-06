import ru.ifmo.se.pokemon.PhysicalMove;
import ru.ifmo.se.pokemon.Pokemon;
import ru.ifmo.se.pokemon.Stat;
import ru.ifmo.se.pokemon.Status;
import ru.ifmo.se.pokemon.Type;
import java.lang.Math;

public class Facade extends PhysicalMove{
	public Facade(){
		accuracy = 100;
		power = 70;
		type = Type.NORMAL;
	}
	
	protected String describe(){
		return "uses Facade";
	}
	
	protected void applyOppDamage(Pokemon def, double damage){
		Status cond = def.getCondition();
		if (cond == Status.POISON || cond == Status.PARALYZE){
			damage *= 2;
		}
		def.setMod(Stat.HP, (int) Math.round(damage));
	}
}
